/*****************************************************************************/
/*  json_templetize.c is kept as a separate file,                            */
/*   to allow a decision whether to release the ability to templetize        */
/*   as a run-time function or only as an executable utility.                */
/*****************************************************************************/
#include "utils.h"
#include "parse_common.h"
#include "json_engine.h"

/*---------------------------------------------------------------------------*/
#ifdef _MSC_VER
    #pragma warning(disable:4820) /* bytes padding added after data member */
#endif

typedef struct  build_nesting_node_TAG
{
    uint16_t          Hash                                         ;
    bool         IsArray                                      ;
    const uint8_t *   PositionOfEntry                              ;
    bool         NestingLevelContainsValidValues              ;
    const char *    PositionOfPropertyNames                      ;
    int16_t           MembersCountInArray_Counter                  ;
    int8_t            MembersCountInArray_InTemplate               ;
    int8_t            MembersCountInArray_InInternalRepresentation ;

} build_nesting_node_T ;

#ifdef _MSC_VER
    #pragma warning(default:4820)
#endif
/*---------------------------------------------------------------------------*/
#ifdef _MSC_VER
    #pragma warning(disable:4820) /* bytes padding added after data member */
#endif

typedef struct  build_nesting_cb_TAG
{
    build_nesting_node_T  Stack[JSON_MAXIMUM_NESTING] ;
    uint16_t                Position                    ;

} build_nesting_cb_T ;

#ifdef _MSC_VER
    #pragma warning(default:4820)
#endif
/*****************************************************************************/
#if defined(ALLOW_PARSING__JSON)

static _INLINE_ json_rc_T  EnforceSizeLimitations (_I_  void *                 proposed_input_ptr    ,
                                                   _I_  void *                 input_end             ,
                                                   _I_  io_data_stream_cb_T *  output                ,
                                                   _I_  uint16_t                 proposed_output_size   )
{
    if (proposed_input_ptr > input_end)
    {
        return (JSON_RC__BUILDING_PARSED_DATA_EXHAUSTED) ;
    }

    if (output->DataBuf != NULL)
    {
        if (output->Position + proposed_output_size > output->DataBufSize)
        {
            return (JSON_RC__PARSING_BUFFER_SIZE_EXCEEDED) ;
        }
    }

    return (JSON_RC__OK) ;
}

/*****************************************************************************/
static _INLINE_ void   Init_HandleObjectAndArrayEnd (_IO_ traverser_nesting_cb_T * nesting      ,
                                                     _I_  io_data_stream_cb_T *    output       ,
                                                     _I_  uint8_t *                  input_ptr     )
{
          property_table_entry_T *  output_start_entry       ;
    const property_table_entry_T *  input_start_entry        ;
    uint16_t                          input_relative_position  ;
    uint16_t                          input_object_length      ;
    bool                         may_be_more = true       ;


    while (may_be_more  &&  (nesting->Position > 0))
    {
        input_relative_position = (uint16_t)(input_ptr - nesting->Stack[nesting->Position].PositionOfEntry_Input) ;

        input_start_entry = (const property_table_entry_T *)nesting->Stack[nesting->Position].PositionOfEntry_Input ;

        input_object_length = COMPLEX_OBJECT_LENGTH (input_start_entry->Common.PropertyType) ;

        if (input_relative_position < input_object_length)
        {
            may_be_more = false ;
        }
        else
        {
            if (output->DataBuf != NULL)
            {
                output_start_entry = (property_table_entry_T *)nesting->Stack[nesting->Position].PositionOfEntry_Output ;

                output_start_entry->Common.PropertyType &= PROPERTY_TYPE__MASK__OBJECT_OR_ARRAY_OR_VALUE ;

                output_start_entry->Common.PropertyType |= &output->DataBuf[output->Position] - (uint8_t *)output_start_entry ;
            }

            -- nesting->Position ;

            ++ nesting->Stack[nesting->Position].MembersCountInArray_Counter ;    /* No harm if it's not an array */
        }
    }
}
/*****************************************************************************/
json_rc_T    __JSON_Init (__O  void *   json_internal       ,
                        _IO_ uint16_t * json_internal_size  ,
                        _I_  void *   json_template       ,
                        _I_  uint16_t   json_template_size  )
{
    io_data_stream_cb_T              output                                             ;
    const uint8_t *                    input_ptr       = (const uint8_t *)json_template     ;
    const uint8_t *                    input_end                                          ;
    const property_table_entry_T *   input_entry                                        ;
          property_table_entry_T *   output_entry    = NULL                             ;
    const json_template_header_T *   template_header = (const json_template_header_T *)input_ptr  ;
          json_internal_header_T     internal_header = {0}                              ;
    traverser_nesting_cb_T           nesting         = {0}                              ;
    uint16_t                           size_to_process__input                             ;
    uint16_t                           size_to_process__output                            ;
    uint16_t                           value_size                                         ;
    json_rc_T                        rc              = JSON_RC__OK                      ;



    if (*json_internal_size < sizeof(json_internal_header_T))
        return (JSON_RC__PARSING_BUFFER_SIZE_EXCEEDED) ;
    if (json_template_size  < sizeof(json_template_header_T))
        return (JSON_RC__BUILDING_PARSED_DATA_EXHAUSTED) ;

    output.DataBuf     = (uint8_t *)json_internal      ;
    output.DataBufSize =         *json_internal_size ;
    output.Position    =  sizeof (internal_header)   ;

    internal_header.Version  =   (template_header->Version &  JSON_DATA_MASK__STUCTURE_VERSION)
                                | JSON_DATA_TYPE__INTERNAL_REPRESENTATION ;

    internal_header.HashSeed          = template_header->HashSeed ;
    internal_header.PropertyTableSize = template_header->PropertyTableSize ;

/*  internal_header.ValuesCount       = 0 ;  ... No need because of MemSet(0) */

    internal_header.MaximumSize       = *json_internal_size ;

    input_ptr += sizeof (*template_header) ;
    input_end = input_ptr + template_header->PropertyTableSize ;

    while (input_ptr < input_end)
    {
        size_to_process__input  = sizeof(input_entry ->Common) ;  /* A minimal assumption for the next iteration */
        size_to_process__output = sizeof(output_entry->Common) ;

        UpdateBestCaseRc (&rc , EnforceSizeLimitations (input_ptr + size_to_process__input , input_end , &output , size_to_process__output)) ;

        if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
        {
            return (rc) ;
        }

        input_entry  = (const property_table_entry_T *)input_ptr  ;

        if (output.DataBuf != NULL)
        {
            output_entry = (property_table_entry_T *)&output.DataBuf[output.Position] ;

            output_entry->Common = input_entry->Common ;
        }

        if (IS_ARRAY (input_entry->Common.PropertyType))
        {
            /************/
            /* An array */
            /************/
            size_to_process__input  = sizeof(input_entry ->Array) ;
            size_to_process__output = sizeof(output_entry->Array) ;

            UpdateBestCaseRc (&rc , EnforceSizeLimitations (input_ptr + size_to_process__input , input_end , &output , size_to_process__output)) ;

            if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
            {
                return (rc) ;
            }

            if (output_entry != NULL)
            {
                output_entry->Array = input_entry->Array ;

                output_entry->Array.MembersCount_ExpectedByTemplate = input_entry->Array.MembersCount ;
            }

            ++ nesting.Position ;

            nesting.Stack[nesting.Position].IsArray                        = true ;
            nesting.Stack[nesting.Position].MembersCountInArray_InTemplate = input_entry->Array.MembersCount ;
            nesting.Stack[nesting.Position].MembersCountInArray_Counter    = 0 ;
            nesting.Stack[nesting.Position].PositionOfEntry_Input          = input_ptr  ;
            nesting.Stack[nesting.Position].PositionOfEntry_Output         = (uint8_t *)output_entry ;
        }
        else if (IS_OBJECT (input_entry->Common.PropertyType))
        {
            /*****************/
            /* A JSON Object */
            /*****************/
            ++ nesting.Position ;

            nesting.Stack[nesting.Position].IsArray                   = false ;
            nesting.Stack[nesting.Position].PositionOfEntry_Input     = input_ptr  ;
            nesting.Stack[nesting.Position].PositionOfEntry_Output    = (uint8_t *)output_entry ;
        }
        else
        {
            /*******************************************/
            /* A single-value item, or an object-start */
            /*******************************************/
            if (IS_SINGLE_VALUE (input_entry->Common.PropertyType))
            {
                UpdateBestCaseRc (&rc , DetermineValueSize (&value_size , input_entry->Common.PropertyType)) ;

                size_to_process__output += value_size ;

                UpdateBestCaseRc (&rc , EnforceSizeLimitations (input_ptr + size_to_process__input , input_end , &output , size_to_process__output)) ;

                if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
                {
                    return (rc) ;
                }

                if (output_entry != NULL)
                {
                    MemSet (&output_entry->Common + 1 , 0 , value_size) ;
                }

                ++ nesting.Stack[nesting.Position].MembersCountInArray_Counter ;    /* No harm if it's not an array */
            }
        }

        input_ptr  += size_to_process__input  ;

        output.Position += size_to_process__output ;
        
        Init_HandleObjectAndArrayEnd (&nesting , &output , input_ptr) ;
    }

    internal_header.PropertyTableSize =   output.Position
                                        - sizeof(json_internal_header_T)  ;

    *json_internal_size = output.Position ;

    if (json_internal != NULL)
    {
        internal_header.CurrentSize = output.Position ;

        MemCpy (json_internal , &internal_header , sizeof(internal_header)) ;
    }

    return (rc) ;
}
/*****************************************************************************/
json_rc_T    __JSON_Parse (__O  void *   json_internal       ,
                         _IO_ uint16_t * json_internal_size  ,
                         _I_  char *   json_text           ,
                         _I_  uint16_t   json_text_size      ,
                         _I_  void *   json_template       ,
                         _I_  uint16_t   json_template_size  ,
                         _I_  uint32_t   flags                )
{
    parse_pass_T    parse_pass_type                             ;
    uint16_t          minimal_internal_size = *json_internal_size ;
    json_rc_T       rc                                          ;


    rc = __JSON_Init ( json_internal          ,
                    &minimal_internal_size  ,
                     json_template          ,
                     json_template_size      ) ;

    if (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        if (flags  &  JSON_PARSE_FLAGS__ESTIMATE_ONLY)
        {
            parse_pass_type = PARSE_PASS__JSON_ESTIMATE_ONLY ;
        }
        else
        {
            parse_pass_type = PARSE_PASS__JSON ;
        }

        rc = ParseCommon (parse_pass_type     ,
                          json_internal       ,
                          json_internal_size  ,
                          json_text           ,
                          json_text_size       ) ;
    }

    return (rc) ;
}
/*****************************************************************************/
static _INLINE_ json_rc_T    EmitCharacter (_IO_ io_data_stream_cb_T *  output            ,
                                            _I_  char                   character_to_emit  )
{
    if (output != NULL)     /* 'output' may be NULL, if a call to 'EmitValue()' was made just to skip an input value */
    {
        if (output->Position >= output->DataBufSize)
        {
            return (JSON_RC__PARSING_BUFFER_SIZE_EXCEEDED) ;
        }

        if (output->DataBuf != NULL)
        {
            output->DataBuf[output->Position] = character_to_emit ;
        }
    
        ++ output->Position ;
    }

    return (JSON_RC__OK) ;
}
/*****************************************************************************/
static _INLINE_ json_rc_T    EmitStringValue_Printable (_IO_ io_data_stream_cb_T *  output           ,
                                                        _I_  char                   string_to_emit[]  )
{
    unsigned    char_index = 0              ;
    json_rc_T   rc         = JSON_RC__OK    ;
    char        value[2]                    ;   /* Suitable for either a simple character, or for an escaped character.  */
    uint16_t      value_len                   ;
    int         i                           ;


    while (string_to_emit[char_index] != '\0')
    {
        value_len =  2u ;
        value[0]  = '\\';

        switch (string_to_emit[char_index])
        {
            case '"':
            case '\\':  value[1] = string_to_emit[char_index] ;    break ;
 
            case '\b':  value[1] = 'b' ;            break ;
            case '\f':  value[1] = 'f' ;            break ;
            case '\n':  value[1] = 'n' ;            break ;
            case '\r':  value[1] = 'r' ;            break ;
            case '\t':  value[1] = 't' ;            break ;
 
            default:    value_len = 1u ;
 
                        value[0] = string_to_emit[char_index] ;
        }

        for (i = 0 ; i < value_len ; i++)
        {
            UpdateBestCaseRc (&rc , EmitCharacter (output , value[i])) ;
        }

        ++ char_index ;
    }

    return (rc) ;   /* Only the last 'rc' is returned.  The rest may be ignored */
}
/*****************************************************************************/
static _INLINE_ json_rc_T    EmitString (_IO_ io_data_stream_cb_T *  output           ,
                                         _I_  char                   string_to_emit[]  )
{
    unsigned    char_index = 0              ;
    json_rc_T   rc         = JSON_RC__OK    ;


    while (string_to_emit[char_index] != '\0')
    {
        UpdateBestCaseRc (&rc , EmitCharacter (output , string_to_emit[char_index])) ;

        ++ char_index ;
    }

    return (rc) ;   /* Only the last 'rc' is returned.  The rest may be ignored */
}
/*****************************************************************************/
static _INLINE_ json_rc_T    EmitPropertyName (_IO_ io_data_stream_cb_T *  output       ,
                                               _I_  char * *               name_to_emit  )
{
    EmitCharacter (output , '"') ;        

    while (**name_to_emit != '\0')
    {
        EmitCharacter (output , **name_to_emit) ;

        ++ *name_to_emit ;
    }

    ++ *name_to_emit ;      /* Skip '\0' */
 
    /************************************************************/
    /* Only the last 'rc' is returned.  The rest may be ignored */
    /************************************************************/
    return (EmitString (output , "\" : ")) ;
}
/*****************************************************************************/
static _INLINE_ json_rc_T    EmitValue (_IO_ io_data_stream_cb_T *  output    ,
                                        _IO_ const uint8_t * *        input_ptr  )
{
    static const char *             booleans[]   = { "false" , "true" } ;
    const property_table_entry_T *  input_entry  = (const property_table_entry_T *)*input_ptr    ;
    const void *                    input_value  = (const void *)(&input_entry->Common + 1)      ;    
#ifdef SUPPORT_REAL_NUMBERS
    char                            number[23 /* StrLen("-2147483648.1234567890") + 1 */]        ;
#else
    char                            number[12 /* StrLen("-2147483648") + 1 */]                   ;
#endif
    const char *                    value_string = ""          ;
    json_rc_T                       rc           = JSON_RC__OK ;
#ifdef SUPPORT_REAL_NUMBERS
    int                             q_right                    ;
    int                             digit                      ;
    uint32_t                          number_left                ;
    uint32_t                          number_right               ;
    uint16_t                          number_index  = 0u         ;
    uint32_t                          absolute_value             ;


    if (   ((input_entry->Common.PropertyType  &  PROPERTY_TYPE_UPPER_MASK) == PROPERTY_TYPE__REAL32__BASE)
        || ((input_entry->Common.PropertyType  &  PROPERTY_TYPE_UPPER_MASK) == PROPERTY_TYPE__UREAL32__BASE))
    {
        if (    ((input_entry->Common.PropertyType  &  PROPERTY_TYPE_UPPER_MASK) == PROPERTY_TYPE__UREAL32__BASE)
            ||  (*(int32_t *)input_value > 0))
        {
            absolute_value = *(uint32_t *)input_value ;
        }
        else
        {
            absolute_value = (uint32_t)-*(int32_t *)input_value ;

            number[number_index] = '-' ;

            number_index++ ;
        }

        q_right = PROPERTY_TYPE__QRIGHT (input_entry->Common.PropertyType) ;

        number_left  =  absolute_value >> q_right  ;
        number_right = (absolute_value << (PROPERTY_TYPE__REAL__MAX_BITS - q_right)) ; /* Flush to the left */

        UlToA (number_left , &number[number_index]) ;

        number_index = (uint16_t)StrLen (number) ;

        number[number_index] = '.'  ;

        number_index++ ;

        while (number_right > 0u)
        {
            uint32_t  bits_0_30 = (number_right << 1) >> 1 ;
            uint32_t  bits_0_28 = (number_right << 3) >> 3 ;
            uint32_t  carry     = ((bits_0_30 + (bits_0_28 << 2)) >> (PROPERTY_TYPE__REAL__MAX_BITS - 1u))  &  1u ;

            /*******************************************************************/
            /* 'digit' = the value of the upper 4 bits                         */
            /*   if we multiplied 'number_right' by 10 into a 36-bit variable  */
            /*******************************************************************/
            digit =    (number_right >> (PROPERTY_TYPE__REAL__MAX_BITS - 1u))   /* Upper nibble of 'number_right << 1' */
                     + (number_right >> (PROPERTY_TYPE__REAL__MAX_BITS - 3u))   /* Upper nibble of 'number_right << 3' */
                     + carry ;                                                  /* Carry from lower 32 bits of 'number_right * 10' */

            /*******************************************************************/
            /* 'number_right' = the value of the lower 32 bits                 */
            /*   if we multiplied 'number_right' by 10 into a 36-bit variable  */
            /*******************************************************************/
            number_right = (number_right << 3) + (number_right << 1) ;

            number[number_index] = (char)(digit + '0')  ;

            number_index++ ;
        }

        number[number_index]  = '\0' ;
       
        value_string = number ;
    }
    else
#endif /* SUPPORT_REAL_NUMBERS */
    {
        switch (PROPERTY_TYPE__CLEAN (input_entry->Common.PropertyType))
        {
            case PROPERTY_TYPE__INT32:      LToA (*(int32_t *)input_value , number) ;
                                            value_string = number ;
                                            break ;

            case PROPERTY_TYPE__UINT32:     UlToA (*(uint32_t *)input_value , number) ;
                                            value_string = number ;
                                            break ;

            case PROPERTY_TYPE__BOOLEAN:    if (*(uint8_t *)input_value == 0)
                                                value_string = booleans[0] ;
                                            else
                                                value_string = booleans[1] ;
                                            break ;

            case PROPERTY_TYPE__RAW:
            case PROPERTY_TYPE__STRING:     if (output != NULL)
                                            {
                                                UpdateBestCaseRc (&rc , JSON_RC__RECOVERED__PARSING_FAILURE) ;
                                            }
                                            break ;

            default:                        UpdateBestCaseRc (&rc , JSON_RC__RECOVERED__PARSING_FAILURE) ;
                                            break ;
        }
    }

    UpdateBestCaseRc (&rc , SkipPropertyTableEntry (input_ptr , GO_INTO_COMPLEX_OBJECTS)) ;

    UpdateBestCaseRc (&rc , EmitString (output , value_string)) ;

    return (rc) ;
}
/*****************************************************************************/

static _INLINE_ json_rc_T  Build_HandleObjectAndArrayBase (_IO_ io_data_stream_cb_T *  output            ,
                                                           _IO_ build_nesting_cb_T *   nesting           ,
                                                           _IO_ const uint8_t * *        input_ptr         ,
                                                           _I_  char *                 property_name_ptr  )
{
    const property_table_entry_T *  input_entry = (const property_table_entry_T *)*input_ptr    ;


    if (IS_SINGLE_VALUE (input_entry->Common.PropertyType))
    {
        return (JSON_RC__NOT_FOUND) ;
    }

    ++ nesting->Position ;

    nesting->Stack[nesting->Position].NestingLevelContainsValidValues = false ;

    nesting->Stack[nesting->Position].PositionOfEntry  = *input_ptr ;

    if (IS_OBJECT (input_entry->Common.PropertyType))
    {
        nesting->Stack[nesting->Position].IsArray = false ;

        *input_ptr += sizeof (input_entry->Common) ;

        return (EmitCharacter (output , '{')) ;
    }
    else if (IS_ARRAY (input_entry->Common.PropertyType))
    {
        nesting->Stack[nesting->Position].IsArray = true ;

        nesting->Stack[nesting->Position].MembersCountInArray_InTemplate               = input_entry->Array.MembersCount_ExpectedByTemplate ;
        nesting->Stack[nesting->Position].MembersCountInArray_InInternalRepresentation = input_entry->Array.MembersCount ;

        nesting->Stack[nesting->Position].MembersCountInArray_Counter  = -1 ;

        nesting->Stack[nesting->Position].PositionOfPropertyNames = property_name_ptr ;

        *input_ptr += sizeof (input_entry->Array) ;

        return (EmitCharacter (output , '[')) ;
    }

    return (JSON_RC__NOT_FOUND) ;
}

/*****************************************************************************/
static  void    UpdateMembersCounterAndPropertyNamesPtr (_IO_ build_nesting_cb_T *  nesting           ,
                                                         _IO_ const char * *        property_name_ptr  )
{
    if (nesting->Stack[nesting->Position].IsArray)
    {
        ++ nesting->Stack[nesting->Position].MembersCountInArray_Counter ;

        if (  nesting->Stack[nesting->Position].MembersCountInArray_Counter
            < nesting->Stack[nesting->Position].MembersCountInArray_InTemplate)
        {
            nesting->Stack[nesting->Position].PositionOfPropertyNames = *property_name_ptr ;
        }
        else
        {
            if (  nesting->Stack[nesting->Position].MembersCountInArray_Counter
                < nesting->Stack[nesting->Position].MembersCountInArray_InInternalRepresentation)
            {
                /************************************************/
                /* Repeat last explicit object's property-names */
                /************************************************/
                *property_name_ptr = nesting->Stack[nesting->Position].PositionOfPropertyNames ;
            }
        }
    }
}
/*****************************************************************************/
static _INLINE_ json_rc_T  Build_HandleObjectAndArrayEnd (_IO_ io_data_stream_cb_T *  output             ,
                                                          _IO_ build_nesting_cb_T *   nesting            ,
                                                          _IO_ const char * *         property_name_ptr  ,
                                                          _I_  uint8_t *                input_ptr           )
{
    const property_table_entry_T *  start_entry                      ;
    uint16_t                          relative_position                ;
    uint16_t                          object_length                    ;
    bool                         may_be_more = true               ;
    json_rc_T                       rc          = JSON_RC__NOT_FOUND ;


    while (may_be_more  &&  (nesting->Position > 0))
    {
        relative_position = (uint16_t)(input_ptr - nesting->Stack[nesting->Position].PositionOfEntry) ;

        start_entry = (const property_table_entry_T *)nesting->Stack[nesting->Position].PositionOfEntry ;

        object_length = COMPLEX_OBJECT_LENGTH (start_entry->Common.PropertyType) ;

        if (relative_position < object_length)
        {
            may_be_more = false ;
        }
        else
        {
            if (nesting->Stack[nesting->Position].IsArray)
            {
                rc = EmitString (output , "]\n") ;
            }
            else
            {
                rc = EmitString (output , "}\n") ;
            }

            -- nesting->Position ;

            UpdateMembersCounterAndPropertyNamesPtr (nesting , property_name_ptr) ;
        }
    }

    return (rc) ;
}

/*****************************************************************************/
static  void    Build_CheckValidityAndNullity (__O  bool *                 value_is_valid  ,
                                               __O  bool *                 value_is_null   ,
                                               _I_  property_table_entry_T *  input_entry      )
{
    if (IS_SINGLE_VALUE (input_entry->Common.PropertyType))
    {
        if (input_entry->Common.PropertyType & PROPERTY_VALIDITY_BIT)
        {
                *value_is_valid = true ;  
        }
        else
        {
                *value_is_valid = false ;  
        }

        if (input_entry->Common.PropertyType & PROPERTY_NULLITY_BIT)
        {
            *value_is_null = true ;
        }
        else
        {
            *value_is_null = false ;
        }
    }
    else
    {
        *value_is_valid = true ;
        *value_is_null  = false ;
    }
}
/*****************************************************************************/
static  json_rc_T   Build_EmitSingleValueObject (_IO_ io_data_stream_cb_T *     output         ,
                                                 _IO_ const uint8_t * *           input_ptr      ,
                                                 _I_  void *                    json_internal  ,
                                                 _I_  property_table_entry_T *  input_entry    ,
                                                 _I_  bool                   value_is_null   )
{
    json_rc_T   rc = JSON_RC__OK    ;


    if (value_is_null)
    {
        UpdateBestCaseRc (&rc , EmitString (output , "null")) ;
        UpdateBestCaseRc (&rc , EmitValue (NULL , input_ptr)) ; /* Skip the input value */
    }
    else
    {
        if (PROPERTY_TYPE__CLEAN (input_entry->Common.PropertyType) == PROPERTY_TYPE__STRING)
        {
            UpdateBestCaseRc (&rc , EmitCharacter (output , '"')) ;

            UpdateBestCaseRc (&rc , EmitStringValue_Printable (output , (const char *)json_internal + *(uint16_t *)(&input_entry->Common + 1))) ;

            UpdateBestCaseRc (&rc , EmitCharacter (output , '"')) ;

            *input_ptr += sizeof(input_entry->Common) + sizeof(uint16_t) ;   /* skip string offset */
        }
        else if (PROPERTY_TYPE__CLEAN (input_entry->Common.PropertyType) == PROPERTY_TYPE__RAW)
        {
            UpdateBestCaseRc (&rc , EmitString (output , (const char *)json_internal + *(uint16_t *)(&input_entry->Common + 1))) ;

            *input_ptr += sizeof(input_entry->Common) + sizeof(uint16_t) ;   /* skip string offset */
        }
        else
        {
            UpdateBestCaseRc (&rc , EmitValue (output , input_ptr)) ;
        }
    }

    return (rc) ;
}
/*****************************************************************************/
json_rc_T    __JSON_Build (__O  char *    json_text           ,
                         _IO_ uint16_t *  json_text_size      ,
                         _I_  void *    json_internal       ,
                         _I_  void *    json_template       )
{
    io_data_stream_cb_T             output                                  ;
    const json_internal_header_T *  internal_header   = (const json_internal_header_T *)json_internal   ;
    const json_template_header_T *  template_header   = (const json_template_header_T *)json_template   ;
    const uint8_t *                   input_ptr         = (const uint8_t *)json_internal + sizeof(json_internal_header_T) ;
    const uint8_t *                   input_end         = (const uint8_t *)input_ptr     + internal_header->PropertyTableSize ;
    const char *                    property_name_ptr = (const char  *)json_template + sizeof(json_template_header_T) + template_header->PropertyTableSize  ;
    const property_table_entry_T *  input_entry       = (const property_table_entry_T *)input_ptr       ;
    build_nesting_cb_T              nesting           = {0}                 ;
    uint16_t                          size_to_process__input                  ;
    bool                         value_is_valid                          ;
    bool                         value_is_null                           ;
    json_rc_T                       rc_tmp                                  ;
    json_rc_T                       rc                = JSON_RC__OK         ;


    output.DataBuf     = (uint8_t *)json_text      ;
    output.DataBufSize =         *json_text_size ;
    output.Position    =          0u             ;

    rc_tmp = Build_HandleObjectAndArrayBase (&output , &nesting , &input_ptr , property_name_ptr) ;
    
    if (rc_tmp == JSON_RC__NOT_FOUND)       /* First entry must be the beginning of an array or an object */
    {
        rc_tmp = JSON_RC__PARSING_FAILURE ;
    }

    UpdateBestCaseRc (&rc , rc_tmp) ;

    while (   (input_ptr < input_end)
           && (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE))
    {
        size_to_process__input  = sizeof(input_entry ->Common) ;  /* A minimal assumption for the next iteration */
        
        if (input_ptr + size_to_process__input > input_end)
        {
            return (JSON_RC__BUILDING_PARSED_DATA_EXHAUSTED) ;
        }

        input_entry = (const property_table_entry_T *)input_ptr  ;

        Build_CheckValidityAndNullity (&value_is_valid , &value_is_null , input_entry) ;

        if (nesting.Stack[nesting.Position].NestingLevelContainsValidValues  &&  value_is_valid)
        {
            EmitString (&output , " ,\n") ;   /* May ignore rc.  It will be noticed soon. */
        }

        if (value_is_valid)
        {
            nesting.Stack[nesting.Position].NestingLevelContainsValidValues = true ;

            if ( ! nesting.Stack[nesting.Position].IsArray)                                 /* Within a JSON Object? */
            {
                UpdateBestCaseRc (&rc , EmitPropertyName (&output , &property_name_ptr)) ;  /* ==> Values are named  */

                if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
                {
                    return (rc) ;
                }
            }

            rc_tmp = Build_HandleObjectAndArrayBase (&output , &nesting , &input_ptr , property_name_ptr) ;

            if (rc_tmp > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
            {
                UpdateBestCaseRc (&rc , rc_tmp) ;
            }
            else if (rc_tmp != JSON_RC__NOT_FOUND)
            {
                return (rc_tmp) ;
            }
            else
            {
                UpdateBestCaseRc (&rc , Build_EmitSingleValueObject (&output , &input_ptr , json_internal , input_entry , value_is_null)) ;
            }
        }
        else
        {
            UpdateBestCaseRc (&rc , EmitValue (NULL , &input_ptr)) ; /* Skip the value */

            if ( ! nesting.Stack[nesting.Position].IsArray)
            {
                UpdateBestCaseRc (&rc , EmitPropertyName (NULL , &property_name_ptr)) ; /* Skip the property_name in property-name-table */
            }
        }

        UpdateMembersCounterAndPropertyNamesPtr (&nesting , &property_name_ptr) ;

        rc_tmp = Build_HandleObjectAndArrayEnd (&output , &nesting , &property_name_ptr , input_ptr) ;

        if (rc_tmp > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
        {
            UpdateBestCaseRc (&rc , rc_tmp) ;
        }
        else if (rc_tmp != JSON_RC__NOT_FOUND)
        {
            return (rc_tmp) ;
        }
    }

    *json_text_size = output.Position ;

    return (rc) ;
}

/*****************************************************************************/
json_rc_T    __JSON_GetArrayMembersCount (__O  uint16_t *  members_count_var   ,
                                        _I_  void *    json_internal       ,
                                        _I_  char *    property_path       ,
                                        _I_  uint16_t    property_path_size   )
{
    property_table_entry__array_T * found_array_start ;
    const property_table_entry_T *  found_property    ;
    uint16_t                          array_index       ;
    json_rc_T                       rc                ;




    rc = FindPropertyByPropertyPath (&found_array_start   ,
                                     &found_property      ,
                                     &array_index         ,
                              (void *)json_internal       , /* Losing 'const'.  Saving space (not duplicating FindPropertyByPropertyPath) */
                                      property_path       ,
                                      property_path_size  ,
                                      ARRAYS__KEEP_AS_IS   ) ;

    if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        return (rc) ;
    }

    if (found_property->Array.Common.PropertyType & PROPERTY_NULLITY_BIT)
    {
        *members_count_var = 0 ;

        return (JSON_RC__VALUE_IS_NULL) ;
    }
    if (!(found_property->Array.Common.PropertyType & PROPERTY_TYPE__ARRAY__BASE))
    {
        return (JSON_RC__VALUE_NOT_AN_ARRAY);
    }
    *members_count_var = found_property->Array.MembersCount ;

    return (rc) ;
}

/*****************************************************************************/
static json_rc_T    GetString (__O  uint8_t *                     value_buffer       ,
                               _IO_ uint16_t *                    value_buffer_size  ,
                               _I_  void *                      json_internal      ,
                               _I_  property_table_entry_T *    string_property     )
{
    const uint16_t    string_offset   = *(const uint16_t *)(&string_property->Common + 1) ;
    const uint8_t *   string_position = (const uint8_t *)json_internal + string_offset    ;
    uint16_t          string_size     = 0                                               ;


    while (string_position[string_size] != '\0')
    {
        if (string_size >= *value_buffer_size)
        {
            return (JSON_RC__PARSING_BUFFER_SIZE_EXCEEDED) ;
        }
    
        value_buffer[string_size] = string_position[string_size] ;

        ++ string_size ;
    }

    *value_buffer_size = (uint8_t)string_size ;

    return (JSON_RC__OK) ;
}
/*****************************************************************************/
static uint8_t    GetStringLength (_I_  void *    json_internal  ,
                                 _I_  uint16_t    string_offset   )
{
    const uint8_t *   string_position = (const uint8_t *)json_internal + string_offset    ;
    uint16_t          string_size     = 0                                               ;


    if (string_offset == 0)
    {
        return (0) ;
    }

    while (string_position[string_size] != '\0')
    {
        ++ string_size ;
    }

    return ((uint8_t)string_size) ;
}
/*****************************************************************************/
json_rc_T    __JSON_GetValue (__O  void *    value_buffer        ,
                            _IO_ uint16_t *  value_buffer_size   ,
                            _I_  void *    json_internal       ,
                            _I_  char *    property_path       ,
                            _I_  uint16_t    property_path_size  )
{
    uint16_t                           array_index       ;
    property_table_entry__array_T *  found_array_start ;
    const property_table_entry_T *   found_property    ;
    uint16_t                           value_size        ;
    json_rc_T                        rc                ;
    uint16_t                           stringLen = 0     ;




    rc = FindPropertyByPropertyPath (&found_array_start   ,
                                     &found_property      ,
                                     &array_index         ,
                              (void *)json_internal       , /* Losing 'const'.  Saving space (not duplicating FindPropertyByPropertyPath) */
                                      property_path       ,
                                      property_path_size  ,
                                      ARRAYS__KEEP_AS_IS   ) ;

    if (rc == JSON_RC__INDEX_FAR_BEYOND_ARRAY_END)
    {
        return (JSON_RC__NOT_FOUND) ;
    }
    else if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        return (rc) ;
    }
    else if ((found_array_start != NULL)  &&  (array_index >= found_array_start->MembersCount))
    {
        return (JSON_RC__NOT_FOUND) ;
    }

    if ( ! (found_property->Common.PropertyType & PROPERTY_VALIDITY_BIT)) 
    {
        return (JSON_RC__VALUE_NOT_VALID) ;
    }

    if ( ! IS_SINGLE_VALUE (found_property->Common.PropertyType))
    {
        return (JSON_RC__NOT_SUPPORTED) ;
    }

    UpdateBestCaseRc (&rc , DetermineValueSize (&value_size , found_property->Common.PropertyType)) ;

    if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        return (rc) ;
    }

    if ((found_property->Common.PropertyType  &  PROPERTY_TYPE__MASK__NONREAL_TYPE) == PROPERTY_TYPE__STRING_BASE)
    {
        stringLen = GetStringLength (json_internal, *(const uint16_t *)(&found_property->Common + 1));

        if ((value_buffer) && (*value_buffer_size < stringLen))
        {
            return (JSON_RC__PARSING_BUFFER_SIZE_EXCEEDED) ;
        }
    }
    else
    {
        if ((value_buffer) && (*value_buffer_size < value_size))
        {
            return (JSON_RC__PARSING_BUFFER_SIZE_EXCEEDED) ;
        }
    }

    if (found_property->Common.PropertyType & PROPERTY_NULLITY_BIT)
    {
        /*****************************************************************/
        /* Nullity may be cehcked right after Validity, but              */
        /*   this would create a hideout for a bug in the caller's code, */
        /*   sending wrong types or buffer-size,                         */
        /*   and not discovering the error                               */
        /*   because thevalue happened to be NULL.                       */
        /*****************************************************************/
        return (JSON_RC__VALUE_IS_NULL) ;
    }

    if ((found_property->Common.PropertyType  &  PROPERTY_TYPE__MASK__NONREAL_TYPE) == PROPERTY_TYPE__STRING_BASE)
    {
        if (value_buffer)
        {
            UpdateBestCaseRc (&rc , GetString ((uint8_t *)value_buffer , value_buffer_size , json_internal , found_property)) ;
        }
        else
        {
            *value_buffer_size = stringLen;
        }
    }
    else
    {
        if (value_buffer)
        {
            MemCpy (value_buffer , &found_property->Common + 1 , value_size) ;
        }

        *value_buffer_size = value_size ;
    }

    return (rc) ;
}
/*****************************************************************************/
json_rc_T    __JSON_SetValue (_IO_ void *    json_internal       ,
                            _IO_ uint16_t *  json_internal_size  ,
                            _I_  void *    value               ,
                            _I_  uint16_t    value_size          ,
                            _I_  char *    property_path       ,
                            _I_  uint16_t    property_path_size  )
{
    json_internal_header_T *         json_header = (json_internal_header_T *)json_internal  ;
    uint16_t                           array_index               ;
    property_table_entry__array_T *  found_array_start         ;
    const property_table_entry_T *   found_property            ;
    json_rc_T                        rc                        ;
 

    if (*json_internal_size < json_header->CurrentSize)
    {
        return (JSON_RC__PARSING_BUFFER_SIZE_EXCEEDED) ;
    }

    json_header->MaximumSize = *json_internal_size ;
   
    rc = FindPropertyByPropertyPath (&found_array_start       ,
                                     &found_property          ,
                                     &array_index             ,
                                      json_internal           ,
                                      property_path           ,
                                      property_path_size      ,
                                      ARRAYS__ALLOW_TO_EXPAND  ) ;

    if (rc == JSON_RC__INDEX_FAR_BEYOND_ARRAY_END)
    {
        rc = JSON_RC__OK ;      /* Array will be expanded  */
    }

    if (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        /*************************************************************************/
        /* found_array_start  &  found_property are NOT CONST ANYMORE            */
        /*                 Deplorable in terms of nice writing, but saves space  */
        /*************************************************************************/

        UpdateBestCaseRc (&rc , SetValueInProperty (               json_internal      ,
                                  (property_table_entry__array_T *)found_array_start  ,
                                         (property_table_entry_T *)found_property     ,
                                                                   array_index        ,
                                                                   value              ,
                                                                   value_size         ,
                                                                   true                )) ; /* full_parse_mode */
    }
    
    *json_internal_size = json_header->CurrentSize ;

    return (rc) ;
}
/*****************************************************************************/
static _INLINE_  json_rc_T     AdjustComplexObjectSizes (_IO_ void *                           json_internal  ,
                                                         _I_  property_table_entry__array_T *  array_start    ,
                                                         _I_  uint16_t                           total_change    )
{
    json_internal_header_T *  header           = (json_internal_header_T *)json_internal ;
    uint8_t *                   property_ptr     = (uint8_t *)(header + 1)                   ;
    const uint8_t *             array_end__before_expansion                                ;
    property_table_entry_T *  entry                                                      ;
    uint16_t                    object_len                                                 ;
    json_rc_T                 rc              = JSON_RC__OK                              ;


    array_end__before_expansion = (const uint8_t *)array_start + COMPLEX_OBJECT_LENGTH (array_start->Common.PropertyType) ;

    while ((property_ptr < array_end__before_expansion)  &&  (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE))
    {
        entry = (property_table_entry_T *)property_ptr ;

        if (   IS_OBJECT (entry->Common.PropertyType)
            || IS_ARRAY  (entry->Common.PropertyType))
        {
            object_len = COMPLEX_OBJECT_LENGTH (entry->Common.PropertyType) ;

            if (       (property_ptr + object_len >  array_end__before_expansion)
                ||
                   (   (property_ptr + object_len == array_end__before_expansion)
                    && (property_ptr <= (uint8_t *)array_start)))
            {
                entry->Common.PropertyType += total_change ; 
            }
        }

        UpdateBestCaseRc (&rc , SkipPropertyTableEntry ((const uint8_t **)&property_ptr , GO_INTO_COMPLEX_OBJECTS)) ; /* As far as 'SkipPropertyTableEntry()' is concerned, 'property_ptr' is const */
    }

     return (rc) ;
}
/*****************************************************************************/
static _INLINE_  json_rc_T     AdjustOffsetOfStrings (_IO_ void *     json_internal      ,
                                                      _I_  uint16_t     new_string_offset  ,
                                                      _I_  int16_t      total_change        )
{
    json_internal_header_T *  header             = (json_internal_header_T *)json_internal  ;
    uint8_t *                   property_ptr       = (uint8_t *)(header + 1)                    ;
    const uint8_t *             property_table_end = property_ptr + header->PropertyTableSize ;
    property_table_entry_T *  entry                                                         ;
    uint16_t *                  string_offset_in_property_table                               ;
    json_rc_T                 rc                 = JSON_RC__OK                              ;

     
    while ((property_ptr < property_table_end)  &&  (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE))
    {
        entry = (property_table_entry_T *)property_ptr ;
  
        if ((PROPERTY_TYPE__CLEAN(entry->Common.PropertyType) == PROPERTY_TYPE__STRING) || (PROPERTY_TYPE__CLEAN(entry->Common.PropertyType) == PROPERTY_TYPE__RAW))
        {
            string_offset_in_property_table = (uint16_t *)(&entry->Common + 1) ;

            if (*string_offset_in_property_table > new_string_offset)
            {
                *string_offset_in_property_table += total_change ;
            }
        }

        UpdateBestCaseRc (&rc , SkipPropertyTableEntry ((const uint8_t **)&property_ptr , GO_INTO_COMPLEX_OBJECTS)) ;  /* As far as 'SkipPropertyTableEntry()' is concerned, 'property_ptr' is const */
    }

    return (rc) ;
}
/*****************************************************************************/
static _INLINE_  json_rc_T   SetValueForString (_IO_ void *    json_internal                     ,
                                                _IO_ uint16_t *  string_offset                     ,
                                                _I_  char *    new_string                        ,
                                                _I_  uint16_t    string_len_from_caller , /* In case of normal string, this is cannonized len. In case of of raw, this is the normal len. */
                                                _I_  uint32_t    stringType)
{
    json_internal_header_T *    internal_header = (json_internal_header_T *)json_internal ;
    uint16_t                      existing_string_len__including_overhead                   ;
    uint16_t                      string_len                                                ;
    int16_t                       total_change                                              ;
    int32_t                       canonized_value                                           ;
    uint16_t                      raw_index           = 0u                                  ;
    uint16_t                      json_internal_index                                       ;
    json_rc_T                   rc                  = JSON_RC__OK                         ;


    if (string_len_from_caller <= MAX_STRING_LEN)
    {
        string_len = string_len_from_caller ;
    }
    else
    {
        string_len = MAX_STRING_LEN ;

        rc = JSON_RC__RECOVERED__STRING_TRUNCATED ;
    }

    if (*string_offset == 0)
    {
        existing_string_len__including_overhead = 0 ;
    }
    else
    {
        existing_string_len__including_overhead = GetStringLength (json_internal , *string_offset) + 1 ;
    }

    total_change = string_len + 1 - existing_string_len__including_overhead ;

    if (internal_header->CurrentSize + total_change > internal_header->MaximumSize)
    {
        return (JSON_RC__PARSING_BUFFER_SIZE_WOULD_HAVE_EXCEEDED) ;
    }

    if (*string_offset == 0)
    {
        *string_offset = internal_header->CurrentSize ;
    }
    else
    {
        MemMove ((char *)json_internal        + *string_offset + string_len + 1u               ,
                 (char *)json_internal        + *string_offset + existing_string_len__including_overhead  ,
                 internal_header->CurrentSize - *string_offset - existing_string_len__including_overhead   ) ;             
    }

    internal_header->CurrentSize += total_change ;

    
    if (stringType == PROPERTY_TYPE__RAW)
    {
        for (json_internal_index = 0  ;  json_internal_index < string_len  ;  json_internal_index++)
        {
            ((char *)json_internal)[*string_offset + json_internal_index] = (char) new_string[raw_index] ;
            raw_index++;
        }
    }
    else /* PROPERTY_TYPE__STRING */
    {
        for (json_internal_index = 0  ;  json_internal_index < string_len  ;  json_internal_index++)
        {
            GetCanonizedCharacter (&canonized_value  ,
                                   &raw_index        ,
                                    new_string       ,
                                    MAX_UINT16        ) ;   /* No need to check input_data_size again - it was checked before. */
         
            ((char *)json_internal)[*string_offset + json_internal_index] = (char)canonized_value ;
        }
    }

    ((char *)json_internal)[*string_offset + string_len] = '\0' ;

    UpdateBestCaseRc (&rc , AdjustOffsetOfStrings (json_internal , *string_offset , total_change)) ;

    return (rc) ;
}
/*****************************************************************************/
json_rc_T   EnsureArrayAccomodatesIndex (_IO_ void *                           json_internal   ,
				                         _IO_ property_table_entry__array_T *  array_start     ,
                                         _I_  uint16_t                           array_index     ,
                                         _I_  bool                          full_parse_mode  )
{
    json_internal_header_T *        json_header = (json_internal_header_T *)json_internal ;
    property_table_entry_T *        entry_after_array                                     ;
    const property_table_entry_T *  default_member                                        ;
    uint16_t                          default_member_size__unexpanded                       ;
    property_table_entry_T *        new_entry                                             ;
    uint32_t                          added_size32                                          ;
    uint16_t                          added_size                                            ;
    uint16_t                          offset_of_array_end__before_expansion                 ;
    uint16_t                          unused_size                                           ;
    uint8_t                           members_count__new                                    ;
    json_rc_T                       rc                                                    ;


    if (   (array_start == NULL)
        || (array_index < array_start->MembersCount))
    {
        return (JSON_RC__OK) ;
    }

    members_count__new = (uint8_t)(array_index + 1) ;
     
    if (members_count__new != array_index + 1)
    {
        /*************************************************************/
        /* array_index + 1  overflowed ==> More than uint8_t can hold  */
        /*************************************************************/
        return (JSON_RC__PARSING_FAILURE) ;
    }

    rc = FindLastExplicitlySpecifiedMember (&default_member , &default_member_size__unexpanded , array_start) ;

    if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        return (rc) ;
    }

    added_size32 = (uint32_t)(array_index + 1 - array_start->MembersCount) * default_member_size__unexpanded ;

    if (json_header->CurrentSize + added_size32 > json_header->MaximumSize)
    {
        return (JSON_RC__PARSING_BUFFER_SIZE_WOULD_HAVE_EXCEEDED) ;
    }

    added_size = (uint16_t)added_size32 ;

    entry_after_array = (property_table_entry_T *)((const uint8_t *)array_start + COMPLEX_OBJECT_LENGTH (array_start->Common.PropertyType)) ;

    offset_of_array_end__before_expansion = (uint16_t)((uint8_t *)entry_after_array - (uint8_t *)json_internal) ;

    if (full_parse_mode)
    {
        MemMove ((uint8_t *)entry_after_array + added_size                                   ,
                          entry_after_array                                                ,
                          json_header->CurrentSize - offset_of_array_end__before_expansion  ) ;
    }

    json_header->PropertyTableSize += added_size ;
    json_header->CurrentSize       += added_size ;

    array_start->MembersCount       = members_count__new ;

    if (full_parse_mode)
    {
        for (         new_entry = entry_after_array                                                                ;
             (uint8_t *)new_entry < (uint8_t *)entry_after_array + added_size                                          ;
                      new_entry = (property_table_entry_T *)((uint8_t *)new_entry + default_member_size__unexpanded)  )
        {
            UpdateBestCaseRc (&rc , CopyUnexpandedAndInvalidated (new_entry , &unused_size , default_member)) ;

            if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
            {
                return (rc) ;
            }
        }

        UpdateBestCaseRc (&rc , AdjustComplexObjectSizes (json_internal , array_start , added_size)) ;

        if (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
        {
            UpdateBestCaseRc (&rc , AdjustOffsetOfStrings (json_internal , 0u , added_size)) ;  /* Adjust all valid strings */
        }
    }
    
    return (rc) ;
}
/*****************************************************************************/
json_rc_T    SetValueInProperty (_IO_ void *                           json_internal      ,
                                 _IO_ property_table_entry__array_T *  found_array_start  ,
                                 _IO_ property_table_entry_T *         found_property     ,
                                 _I_  uint16_t                           array_index        ,
                                 _I_  void *                           value              ,
                                 _I_  uint16_t                           value_size         ,
                                 _I_  bool                          full_parse_mode     )
{
    uint16_t       existing_value_size    ;
    json_rc_T    rc    = JSON_RC__OK    ;


    rc = EnsureArrayAccomodatesIndex (json_internal , found_array_start , array_index , full_parse_mode) ;
    
    if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        return (rc) ;
    }

    if ( ! IS_SINGLE_VALUE (found_property->Common.PropertyType))
    {
        return (JSON_RC__NOT_SUPPORTED) ;
    }

    UpdateBestCaseRc (&rc , DetermineValueSize (&existing_value_size , found_property->Common.PropertyType)) ;

    if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        return (rc) ;
    }

    if (value == NULL)
    {
        found_property->Common.PropertyType |= PROPERTY_NULLITY_BIT ;
    }
    else
    {
        found_property->Common.PropertyType &= ~PROPERTY_NULLITY_BIT ;
        
        if (    (!(found_property->Common.PropertyType  &  PROPERTY_TYPE__MASK__REAL_OR_NONREAL))
             &&  ((found_property->Common.PropertyType  &  PROPERTY_TYPE__MASK__NONREAL_TYPE) == PROPERTY_TYPE__STRING_BASE))
        {
            if (full_parse_mode)
            {
                UpdateBestCaseRc (&rc , SetValueForString (json_internal , (uint16_t *)(&found_property->Common + 1) , (const char *)value , value_size, PROPERTY_TYPE__CLEAN (found_property->Common.PropertyType))) ;
            }
            else
            {
                ((json_internal_header_T *)json_internal)->CurrentSize += value_size + 1 ; /* +1 byte string overhead */
            }
        }
        else
        {
            if (value_size != existing_value_size)
            {
                return (JSON_RC__WRONG_VALUE_SIZE_FOR_TYPE) ;
            }

            if (full_parse_mode)
            {
                MemCpy (&found_property->Common + 1 , value , value_size) ;
            }
        }
    }

    found_property->Common.PropertyType |= PROPERTY_VALIDITY_BIT ;

    return (rc) ;
}
/*****************************************************************************/
#endif /* defined(ALLOW_PARSING__JSON) */
/*****************************************************************************/
#if defined(ALLOW_PARSING__TEMPLATE)
/*****************************************************************************/
static bool  FoundDuplicateHash (_I_ json_template_T *   json_template)
{
    const uint8_t *   property_table_start = (const uint8_t *)(&json_template->Header + 1) ;
    const uint8_t *   property_table_end   = property_table_start + json_template->Header.PropertyTableSize ;
    const uint8_t *   next_pass_start      = property_table_start ;
    const uint8_t *   property_ptr                                ;
    uint16_t          tested_hash                                 ;

    const property_table_entry_T *      entry                   ;


    while (next_pass_start < property_table_end)
    {
        entry = (const property_table_entry_T *)next_pass_start ;

        tested_hash = entry->Common.PropertyHash ;

        property_ptr = next_pass_start + SizeOfTemplateEntry (entry->Common.PropertyType) ;

        next_pass_start = property_ptr ;

        while (property_ptr < property_table_end)
        {
            entry = (const property_table_entry_T *)property_ptr ;

            if (entry->Common.PropertyHash == tested_hash)
            {
                return (true) ;
            }

            property_ptr += SizeOfTemplateEntry (entry->Common.PropertyType) ;
        }
    }

    return (false) ;
}
/*****************************************************************************/
json_rc_T    __JSON_Templetize (__O  void *     output_template               ,
                              _IO_ uint16_t *   output_template_size          ,
                              __O  uint16_t *   minimal_template_size         ,
                              _I_  char *     partly_templetized_json       ,
                              _I_  uint16_t     partly_templetized_json_size  
)
{
    uint16_t              phase_output_size = 0                                  ;
    json_template_T *   json_template     = (json_template_T *)output_template ;
    uint32_t              parse_pass_count  = 0                                  ;
    parse_pass_T        parse_pass_type   = PARSE_PASS__TEMPLATE_PREPASS       ;
    bool             final_pass_done   = false                              ;
    json_rc_T           rc                                                     ;


    if (*output_template_size < sizeof(json_template_header_T))
        return (JSON_RC__PARSING_BUFFER_SIZE_EXCEEDED) ;

    json_template->Header.Version           =   JSON_DATA_STRUCTURE_VERSION__TEMPLATE
                                              | JSON_DATA_TYPE__TEMPLATE              ;

    json_template->Header.HashSeed          = DEFAULT_HASH_STARTING_VALUE ;
    json_template->Header.PropertyTableSize = 0u                          ;

    rc = JSON_RC__NO_HASH_FOUND ;

    while (    ((rc == JSON_RC__NO_HASH_FOUND                   )  &&  (parse_pass_count < 0x10000uL))
    	   ||  ((rc >  JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)  &&  (! final_pass_done)))
    {
        phase_output_size = *output_template_size ;

        rc = ParseCommon ( parse_pass_type              ,
                           json_template                ,
                          &phase_output_size            ,
                           partly_templetized_json      ,
                           partly_templetized_json_size  ) ;

        if (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
        {
            if (FoundDuplicateHash (json_template))
            {
                json_template->Header.HashSeed ++ ;     /* Could do something more mathematically sophisticated, but no need */

				parse_pass_count++ ; 

                rc = JSON_RC__NO_HASH_FOUND ;
            }
            else
            {
                if (IS_PREPASS (parse_pass_type))
                {
                    *minimal_template_size = phase_output_size ;

                    parse_pass_type = PARSE_PASS__TEMPLATE_FINAL ;
                }
                else
                {
                    *output_template_size  = phase_output_size ;

                    final_pass_done = true ;
                }
            }
        }
    }

    return (rc) ;
}
/*****************************************************************************/
#endif /* defined(ALLOW_PARSING__TEMPLATE) */
/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
