#include "parse_common.h"
#include "utils.h"


#ifndef USE__STANDRAD_LIBS
/*****************************************************************************/
/*                  strnicmp function                                          */
/*****************************************************************************/
int     StrNiCmp (_I_ char *   string1  ,
                  _I_ char *   string2  ,
                  _I_ size_t   size      ) 
{
    const unsigned char * ptr1       = (const unsigned char *)string1 ;
    const unsigned char * ptr2       = (const unsigned char *)string2 ;
    size_t                chars_left = size ;
    unsigned char         char1             ;
    unsigned char         char2             ;

    
    do
    {
        char1 = *ptr1++ ;
        char2 = *ptr2++ ;

        if (    (char1 >= 'a')
            &&  (char1 <= 'z'))
        {
            char1 -= 'a' - 'A' ;
        }

        if (    (char2 >= 'a')
            &&  (char2 <= 'z'))
        {
            char2 -= 'a' - 'A' ;
        }

        -- chars_left ;

    } while (     (chars_left >    0 )
              &&  (char1      != '\0')
              &&  (char1      == char2)) ;

    return ((int)char1 - (int)char2) ;
}
/*****************************************************************************/
/*                  memmove function                                          */
/*****************************************************************************/
void  MemMove (__O void *   out_buf  ,
               _I_ void *   in_buf   ,
               _I_ size_t   size      )
{
	const char *    src             = (const char *)in_buf  ;
	char *          dst             = (char *      )out_buf ;
    size_t          bytes_remaining = size                  ;


	if (dst <= src)
    {
	    while (bytes_remaining > 0)
        {
            bytes_remaining-- ;

		    *dst++ = *src++ ;
        }
    }
    else
    {
	    src += size ;
	    dst += size ;

	    while (bytes_remaining > 0)
        {
            bytes_remaining-- ;

		    *--dst = *--src ;
        }
    }
}
/*****************************************************************************/
/*                  memcpy function                                          */
/*****************************************************************************/
void  MemCpy (__O void *   out_buf  ,
              _I_ void *   in_buf   ,
              _I_ size_t   size      )
{
	const char *    src             = (const char *)in_buf  ;
	char *          dst             = (char *      )out_buf ;
    size_t          bytes_remaining = size                  ;


	while (bytes_remaining > 0)
    {
        bytes_remaining-- ;

		*dst++ = *src++ ;
    }
}
/*****************************************************************************/
/*                  memset function                                          */
/*****************************************************************************/
void  MemSet (__O void *      out_buf     ,
              _I_ int         byte_value  ,
              _I_ size_t      size          )
{
	char *      dst             = (char *) out_buf ;
    size_t      bytes_remaining = size             ;


	while (bytes_remaining > 0)
    {
        bytes_remaining-- ;

		*dst++ = (char)byte_value ;
    }
}
/*****************************************************************************/
/*                  strlen function                                          */
/*****************************************************************************/
size_t  StrLen (_I_ char *   string)
{
    const char *    ptr     ;

    for (ptr = string  ;  *ptr != '\0'  ;  ++ptr)
    {
        /**********************/
        /* Just advance 'ptr' */
        /**********************/
    }

    return (ptr - string) ;
}
#endif /*not USE__STANDRAD_LIBS */
#if (! defined(USE__STANDRAD_LIBS))  || defined(ewarm) || defined(__GCC__)
/*****************************************************************************/
/*                  ltoa function                                            */
/*****************************************************************************/
void    LToA (_I_  int32_t     val  ,
              __O  char *    buf   )
{
    if (val < 0)
    {
        buf[0] = '-' ;

        UlToA ((uint32_t)-val , buf + 1) ;
    }
    else
    {
        UlToA (val , buf) ;
    }
}

#endif
/*****************************************************************************/
/*                  ultoa function                                           */
/*****************************************************************************/
#if (! defined(USE__STANDRAD_LIBS))  ||  defined(__TI_ARM__) || defined(ewarm) || defined(__GCC__)
void    UlToA (_I_  uint32_t    val  ,
               __O  char *    buf   )
{
    size_t      string_len      = 0     ;
    uint32_t      remaining_value = val   ;


    *buf = '\0' ;

    do
    {
        MemMove (buf + 1 , buf , string_len + 1) ;

        *buf            = remaining_value % 10 + '0' ;
        remaining_value = remaining_value / 10 ;

        string_len++ ;
    }
    while (remaining_value >  0u) ;
}
#endif
/*****************************************************************************/
#ifdef USE__PRETEND_TO_USE_PARAMETER

#ifdef _MSC_VER
#pragma warning(disable:4100)   /* 'parameter' : unreferenced formal parameter */
#endif

void    PretendToUseParameter (const void *  parameter)
{
}

#ifdef _MSC_VER
#pragma warning(default:4100)   /* 'parameter' : unreferenced formal parameter */
#endif

#endif /* USE__PRETEND_TO_USE_PARAMETER */
/*****************************************************************************/
/* NextHash() algorithm is based on CCITT CRC16.                             */
/*****************************************************************************/
uint16_t  NextHash (_I_ uint16_t  starting_hash16  ,
                  _I_ uint8_t   new_val8          )   /*@ Suspicious.  Gets stuck if reaches 0000 */
{
    const uint16_t    polynomial   = 0x1021u         ;
    uint16_t          current_hash = starting_hash16 ;
    uint8_t           current_bit  = 0x80u           ;
    int             need_to_xor_with_polynomial    ;
    uint16_t          i                              ;


    for (i = 0  ;  i < 8  ;  i++)
    {
        need_to_xor_with_polynomial = current_hash  &  0x8000 ;

        current_hash <<= 1 ;

        if (new_val8  &  current_bit)
        {
            current_hash += 1 ;
        }

        if (need_to_xor_with_polynomial)
        {
            current_hash ^= polynomial ;
        }

        current_bit >>= 1 ;
    }

    return (current_hash) ;
}
/*****************************************************************************/
void     SkipWhitespace (_IO_ in_data_stream_cb_T *  input_text)
{
    while (    (input_text->Position < input_text->DataBufSize)
           &&  ( input_text->DataBuf[input_text->Position] <= ' ') )
    {
        input_text->Position++ ;
    }
}
/*****************************************************************************/
json_rc_T   DetermineValueSize (__O  uint16_t *  value_size    ,
                                _I_  uint16_t    property_type  )
{
    uint16_t      top_level_base      ;
    uint16_t      mid_level_base      ;
    json_rc_T   rc = JSON_RC__OK    ;


    top_level_base = property_type  &  PROPERTY_TYPE__MASK__OBJECT_OR_ARRAY_OR_VALUE ;
    mid_level_base = property_type  &  PROPERTY_TYPE__MASK__REAL_OR_NONREAL ;

    if (mid_level_base == 0u)   /* Non-Real */
    {
        mid_level_base = property_type  &  PROPERTY_TYPE__MASK__NONREAL_TYPE ;
    }

    if (top_level_base != PROPERTY_TYPE__SINGLE_VALUE__BASE)
    {
        /********************************************/
        /* Special Value.  Nothing more to do here  */
        /********************************************/
            
        *value_size = 0 ;
    }
    else if (   (mid_level_base == PROPERTY_TYPE__STRING_BASE)
                || (mid_level_base == PROPERTY_TYPE__BOOLEAN_BASE))
    {
        *value_size = sizeof(uint16_t) ;     /* Offset of string */
    }
    else if (   (mid_level_base == PROPERTY_TYPE__INT32_BASE)
             || (mid_level_base == PROPERTY_TYPE__UINT32_BASE)
             || (mid_level_base == PROPERTY_TYPE__REAL32__BASE)
             || (mid_level_base == PROPERTY_TYPE__UREAL32__BASE))
    {
        *value_size = sizeof(uint32_t) ;
    }
    else
    {
        rc = JSON_RC__UNEXPECTED_ERROR ;
    }

    return (rc) ;
}
/*****************************************************************************/
json_rc_T   ReadIntegerAndSkip (__O  uint32_t *              integer        ,
                                _IO_ in_data_stream_cb_T * input_text     ,
                                _I_  uint32_t                minimum_value  ,
                                _I_  uint32_t                maximum_value  ,
                                _I_  uint32_t                default_value   )
{
    int         digits_count    = 0    ;
    uint32_t      tentative_value = 0uL  ;
    uint16_t      new_digit              ;


    while (   (tentative_value <= maximum_value)
           && (input_text->Position < input_text->DataBufSize )
           && (input_text->DataBuf[input_text->Position] >= '0')
           && (input_text->DataBuf[input_text->Position] <= '9'))
    {
        new_digit = input_text->DataBuf[input_text->Position] - '0' ;

        ++ input_text->Position ;
        ++ digits_count ;

        /******************************************************/
        /* tentative_value = tentative_value * 10 + new_digit */
        /******************************************************/
        tentative_value = (tentative_value << 3) + (tentative_value << 1) + new_digit ;
    }

    /*********************************/
    /* Skip remaining digits, if any */
    /*********************************/
    while (   (input_text->Position < input_text->DataBufSize )
           && (input_text->DataBuf[input_text->Position] >= '0')
           && (input_text->DataBuf[input_text->Position] <= '9'))
    {
        input_text->Position++ ;
    }

    SkipWhitespace (input_text) ;
    
    if (digits_count == 0)
    {
        *integer = default_value ;
    }
    else if (tentative_value < minimum_value)
    {
        *integer = minimum_value ;
    }
    else if (tentative_value > maximum_value)
    {
        *integer = maximum_value ;
    }
    else
    {
        *integer = (uint16_t)tentative_value ;

        return (JSON_RC__OK) ;
    }

    return (JSON_RC__RECOVERED__PARSING_FAILURE) ;
}
/*****************************************************************************/
static  json_rc_T   HashPopertyPathSegment (_IO_ uint16_t *               hash       ,
                                            _IO_ in_data_stream_cb_T *  input_text  )
{
    int32_t       canonized_value     ;
    json_rc_T   rc  = JSON_RC__OK   ;


    ++ input_text->Position ;   /* Remove '"' known to be there */

    while (   (input_text->Position  < input_text->DataBufSize)
            && (input_text->DataBuf[input_text->Position] != '"'))
    {
        UpdateBestCaseRc (&rc , GetCanonizedCharacter (&canonized_value         ,
                                                        &input_text->Position     ,
                                            (const char *)input_text->DataBuf      ,
                                                        input_text->DataBufSize   )) ;

        if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
        {
            return (rc) ;
        }

        if (canonized_value != CANONIZED_VALUE__NOT_FOUND)
        {
            *hash = NextHash (*hash , (uint8_t)(canonized_value & 0xFFu)) ;

            if (canonized_value & CANONIZED_VALUE__UNICODE)
            {
                /*******************************************************/
                /* writing unicode in little-endian, regardless of BOM */
                /*******************************************************/

                *hash = NextHash (*hash , (uint8_t)((canonized_value >> 8)  & 0xFFu)) ;
            }
        }
    }

    if (   (input_text->Position < input_text->DataBufSize)
        && (input_text->DataBuf[input_text->Position] == '"'))
    {
        ++ input_text->Position ;
    }

    return (rc) ;
}
/*****************************************************************************/
static json_rc_T  IncreaseNestingAccordingToEntry (_IO_ parser_nesting_cb_T *    parser_nesting       ,
                                                   _I_  property_table_entry_T * property_table_entry  ) /*@ 'const' here, but may eventually be changed through 'current_nesting->PositionOfEntry */
{
    parser_nesting_node_T *     current_nesting = &parser_nesting->Stack[parser_nesting->Position]  ;


    current_nesting->Hash = property_table_entry->Common.PropertyHash ;

    current_nesting->PositionOfEntry = (uint8_t *)property_table_entry ;

    if (IS_OBJECT (property_table_entry->Common.PropertyType))
    {
        current_nesting->IsArray = false ;
    }
    else if (IS_ARRAY (property_table_entry->Common.PropertyType))
    {
        current_nesting->IsArray                                = true ;
        current_nesting->CurrentMemberInArray                   = ARRAY_INDEX__DEFAULT ;
        current_nesting->MembersCountInArray_ExpectedByTemplate = property_table_entry->Array.MembersCount_ExpectedByTemplate ;
    }
    else
    {
        return (JSON_RC__OK) ;
    }

    if (parser_nesting->Position >= ARRAY_SIZEOF(parser_nesting->Stack) - 1)
    {
        return (JSON_RC__NESTING_EXCEEDED) ;
    }

    ++ parser_nesting->Position ;

    return (JSON_RC__OK) ;
}
/*****************************************************************************/
static bool  IsIntermediateSubsegment (_I_ in_data_stream_cb_T *    input_text)
{
    uint16_t  tentative_position = input_text->Position   ;


    for (tentative_position = input_text->Position  ;  tentative_position < input_text->DataBufSize  ;  tentative_position++)
    {
        if (   (input_text->DataBuf[tentative_position] != ']')
            && (input_text->DataBuf[tentative_position] != '.'))
        {
            return (true) ;
        }
    }

    return (false) ;
}
/*****************************************************************************/
static  void    UpdateHashAndArrayIndex (_IO_ uint16_t *              hash            ,
                                         _IO_ uint32_t *              array_index_32  ,
                                         _I_  parser_nesting_cb_T * parser_nesting   )
{
    uint32_t      i       ;


    if (*array_index_32 > parser_nesting->Stack[parser_nesting->Position - 2].MembersCountInArray_ExpectedByTemplate - 1u)
    {
        /**************************************************************************/
        /* For hashing purposes, keep using the last explicitly specieifc member  */
        /*@ Can probably eliminate hashes for array members                       */
        /**************************************************************************/
        *array_index_32 = parser_nesting->Stack[parser_nesting->Position - 2].MembersCountInArray_ExpectedByTemplate - 1u ;
    }

    for (i = 0  ;  i <= *array_index_32  ;  i++)
    {
        *hash = NextHash (*hash , 0) ;
    }

    *array_index_32 = ARRAY_INDEX__NONE ;
}
/*****************************************************************************/
static _INLINE_  json_rc_T  PathParserRewind (__O const property_table_entry__array_T * * found_array_start     ,
                                              __O const property_table_entry_T * *        found_property        ,
                                              __O uint16_t *                                array_index           ,
                                              __O parser_nesting_cb_T *                   parser_nesting        ,
                                              __O in_data_stream_cb_T *                   input_text            ,
                                              __O uint16_t *                                hash                  ,
                                              _I_ /* const */ json_internal_header_T *    json_header            )
{
    input_text->Position = 0u ;

    MemSet (parser_nesting , 0 , sizeof(*parser_nesting)) ;

    *found_array_start = NULL ;
    *found_property    = (const property_table_entry_T *)(json_header + 1) ;
    *array_index       = ARRAY_INDEX__NONE ;

    IncreaseNestingAccordingToEntry (parser_nesting , *found_property) ;

    if (parser_nesting->Position == 0)
    {
        return (JSON_RC__UNEXPECTED_ERROR) ;
    }

    *hash = parser_nesting->Stack[0].Hash ;

    return (JSON_RC__OK) ;
}
/*****************************************************************************/
static _INLINE_
json_rc_T   CopyAndInvalidateSingleValue (__O  property_table_entry_T * *       output                          ,
                                          __O  uint16_t *                         new_member_size__unexpanded     ,
                                          _IO_ const property_table_entry_T * * input                            )
{
    uint16_t      value_size  ;
    json_rc_T   rc          ;


    rc = DetermineValueSize (&value_size , (*input)->Common.PropertyType) ;

    if (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
    {
        if (*output != NULL)
        {
            MemSet (&(*output)->Common + 1 , 0 , value_size) ;

            *output = (property_table_entry_T *)((uint8_t *)*output + sizeof((*output)->Common) + value_size) ;
        }

        *new_member_size__unexpanded += value_size ;

        *input = (const property_table_entry_T *)((const uint8_t *)*input + sizeof((*input)->Common) + value_size) ;
    }

    return (rc) ;
}
/*****************************************************************************/
static _INLINE_
void    HandleEndOfValue (_IO_       property_table_entry_T * *  output  ,
                          _IO_ const property_table_entry_T * *  input   ,
                          _IO_       traverser_nesting_cb_T *    nesting  )
{
    bool                         end_of_value = true     ;
    uint16_t                          output_object_length    ;
          property_table_entry_T *  output_object           ;
    const property_table_entry_T *  input_object            ;
    const uint8_t *                   input_object_end        ;


    while (end_of_value  &&  (nesting->Position > 0))
    {
        if (nesting->Stack[nesting->Position].IsArray)
        {
            ++ nesting->Stack[nesting->Position].MembersCountInArray_Counter ;

            if (nesting->Stack[nesting->Position].MembersCountInArray_Counter >= nesting->Stack[nesting->Position].MembersCountInArray_InTemplate)
            {
                /***************************************************************/
                /* Skip the rest of the array, since this is the expanded part */
                /***************************************************************/
                *input = (const property_table_entry_T *)nesting->Stack[nesting->Position].PositionOfEntry_Input ;

                *input = (const property_table_entry_T *)(nesting->Stack[nesting->Position].PositionOfEntry_Input
                                                            + COMPLEX_OBJECT_LENGTH ((*input)->Array.Common.PropertyType)) ;
            }
        }

        input_object     = (const property_table_entry_T *)nesting->Stack[nesting->Position].PositionOfEntry_Input ;
        input_object_end = (const uint8_t *)input_object + COMPLEX_OBJECT_LENGTH (input_object->Common.PropertyType) ;

        if ((const uint8_t *)*input < input_object_end)
        {
            end_of_value = false ;
        }
        else
        {
            if (*output != NULL)
            {
                output_object = (property_table_entry_T *)nesting->Stack[nesting->Position].PositionOfEntry_Output ;

                output_object_length = (uint16_t)((uint8_t *)*output - (uint8_t *)output_object) ;

                if (IS_OBJECT (output_object->Common.PropertyType))
                {
                    output_object->Common.PropertyType = PROPERTY_TYPE__OBJECT__BASE | output_object_length ;
                }
                else /* IS_ARRAY() */
                {
                    output_object->Common.PropertyType = PROPERTY_TYPE__ARRAY__BASE  | output_object_length ;

                    output_object->Array.MembersCount_ExpectedByTemplate = input_object->Array.MembersCount_ExpectedByTemplate ;
                    output_object->Array.MembersCount                    = input_object->Array.MembersCount_ExpectedByTemplate ; /* Not a copy-paste error */
                }
            }

            -- nesting->Position ;
        }
    }
}
/*****************************************************************************/
json_rc_T   CopyUnexpandedAndInvalidated (__O  property_table_entry_T *    new_member_location             ,
                                          __O  uint16_t *                    new_member_size__unexpanded     ,
                                          _I_  property_table_entry_T *    default_member__may_be_expanded  )
{
    traverser_nesting_cb_T          nesting        = {0}                                ;
          property_table_entry_T *  output         = new_member_location                ;
    const property_table_entry_T *  input          = default_member__may_be_expanded    ;
    const property_table_entry_T *  end_of_input                                        ;
    json_rc_T                       rc             = JSON_RC__OK                        ;


    *new_member_size__unexpanded = 0 ;

    if (IS_SINGLE_VALUE (input->Common.PropertyType))
    {
        end_of_input = input + 1 ;
    }
    else
    {
        end_of_input = (const property_table_entry_T *)
                       ((const uint8_t *)input + COMPLEX_OBJECT_LENGTH (input->Common.PropertyType)) ;
    }

    while (input < end_of_input)
    {
        if (output != NULL)
        {
            output->Common = input->Common ;

            output->Common.PropertyType = PROPERTY_TYPE__CLEAN (input->Common.PropertyType) ;
        }

        *new_member_size__unexpanded += sizeof (input->Common) ;

        if (IS_SINGLE_VALUE (input->Common.PropertyType))
        {
            UpdateBestCaseRc (&rc , CopyAndInvalidateSingleValue (&output , new_member_size__unexpanded , &input)) ;

            if (    (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)    /* Error */
                ||  (nesting.Position == 0))                            /* No nesting - Default member is a single value */
            {
                return (rc) ;
            }

            HandleEndOfValue (&output , &input , &nesting) ;
        }
        else
        {
            ++ nesting.Position ;

            nesting.Stack[nesting.Position].PositionOfEntry_Input  = (const uint8_t *)input  ;
            nesting.Stack[nesting.Position].PositionOfEntry_Output = (      uint8_t *)output ;

            if (IS_OBJECT (input->Common.PropertyType))
            {
                nesting.Stack[nesting.Position].IsArray = false ;

                input = (const property_table_entry_T *)(&input->Common + 1) ;

                if (output != NULL)
                {
                    output = (property_table_entry_T *)(&output->Common + 1) ;
                }
            }
            else /* (IS_ARRAY(input->Common.PropertyType)) */
            {
                nesting.Stack[nesting.Position].IsArray = true ;

                nesting.Stack[nesting.Position].MembersCountInArray_InTemplate = input->Array.MembersCount_ExpectedByTemplate ;
                nesting.Stack[nesting.Position].MembersCountInArray_Counter    = 0 ;

                *new_member_size__unexpanded +=  sizeof (input->Array) - sizeof (input->Common) ;

                input = (const property_table_entry_T *)(&input->Array + 1) ;

                if (output != NULL)
                {
                    output = (property_table_entry_T *)(&output->Array + 1) ;
                }
            }
        }
    }

    return (rc) ;
}
/*****************************************************************************/
#if defined(ALLOW_PARSING__JSON)

json_rc_T   FindPropertyByPropertyPath (__O  property_table_entry__array_T * *  found_array_start       ,
                                        __O  const property_table_entry_T * *   found_property          ,
                                        __O  uint16_t *                           array_index             ,
		 	 			                _IO_ void *                             json_internal           ,
                                        _I_  char *                             property_path           ,
                                        _I_  uint16_t                             property_path_size      ,
                                        _I_  expanding_array_behavior_T         expanding_array_behavior )
{
    const json_internal_header_T *  json_header    = (const json_internal_header_T *)json_internal ;
    uint16_t                          hash                               ;
    parser_nesting_cb_T             parser_nesting                     ;
    in_data_stream_cb_T             input_text                         ;
    uint32_t                          array_index_32 = ARRAY_INDEX__NONE ;
    json_rc_T                       rc             = JSON_RC__OK       ;


    *found_property = (const property_table_entry_T *)(json_header + 1) ;

    if (   (json_header->PropertyTableSize < sizeof ((*found_property)->Common))
        || (property_path_size == 0))
    {
        return (JSON_RC__NOT_FOUND) ;
    }

    input_text.DataBuf     = (const uint8_t *)property_path      ;
    input_text.DataBufSize =                property_path_size ;

    rc = PathParserRewind ((const property_table_entry__array_T * *)found_array_start , found_property , array_index , &parser_nesting , &input_text , &hash , json_header) ;

    while (    (input_text.Position < input_text.DataBufSize)
           &&  (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE))
    {
        if (rc == JSON_RC__REWIND_REQUIRED)
        {
            rc = PathParserRewind ((const property_table_entry__array_T * *)found_array_start , found_property , array_index , &parser_nesting , &input_text , &hash , json_header) ;
        }

        if (   (input_text.DataBuf[input_text.Position] == '.')
            || (input_text.DataBuf[input_text.Position] == ']'))
        {
            ++ input_text.Position ;        /* Ignore  */
        }
        else if (input_text.DataBuf[input_text.Position] == '"')
        {
            /*****************************************/
            /* Handle path segment - named property  */
            /*****************************************/
            UpdateBestCaseRc (&rc , HashPopertyPathSegment (&hash , &input_text)) ;
            if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
            {
                return (rc) ;
            }

            UpdateBestCaseRc (&rc , FindPropertyInBranch (
                  (const property_table_entry__array_T * *)found_array_start            ,
                                                           found_property               ,
                                                           json_internal                ,
                                                          &parser_nesting               ,
                                                           parser_nesting.Position - 1  ,
                                                           hash                         ,
                                                           ARRAY_INDEX__NONE            ,
                                                           expanding_array_behavior      )) ;
            if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
            {
                return (rc) ;
            }

            UpdateBestCaseRc (&rc , IncreaseNestingAccordingToEntry (&parser_nesting , *found_property)) ;
        }
        else if (input_text.DataBuf[input_text.Position] == '[')
        {
            /***************************************/
            /* Handle path segment - array member  */
            /***************************************/
            if ( ! parser_nesting.Stack[parser_nesting.Position - 1].IsArray)
            {
                return (JSON_RC__NOT_FOUND) ;
            }

            ++ input_text.Position ;

            UpdateBestCaseRc (&rc , ReadIntegerAndSkip (&array_index_32        ,
                                                        &input_text            ,
                                                         ARRAY_INDEX__MINIMUM  ,
                                                         ARRAY_INDEX__MAXIMUM  ,
                                                         ARRAY_INDEX__DEFAULT   )) ;

            if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
            {
                return (rc) ;
            }

            parser_nesting.Stack[parser_nesting.Position - 1].CurrentMemberInArray = (uint8_t)array_index_32 ;

            UpdateBestCaseRc (&rc , FindPropertyInBranch (
                  (const property_table_entry__array_T * *)found_array_start            ,
                                                           found_property               ,
                                                           json_internal                ,
                                                          &parser_nesting               ,
                                                           parser_nesting.Position - 2  ,
                                                           hash                         ,
                                                   (uint16_t)array_index_32               ,
                                                           expanding_array_behavior      )) ;
            if (    (rc == JSON_RC__INDEX_FAR_BEYOND_ARRAY_END)
                || ((rc >  JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)  &&  (array_index_32 >= (*found_array_start)->MembersCount)))                
            {
                if (expanding_array_behavior != ARRAYS__ALLOW_TO_EXPAND)
                {
                    return (JSON_RC__NOT_FOUND) ;
                }

                rc = EnsureArrayAccomodatesIndex ( json_internal                                         ,
                                                  *found_array_start                                     ,
                                           (uint16_t)array_index_32                                        ,
                                                   (expanding_array_behavior == ARRAYS__ALLOW_TO_EXPAND)  ) ;

                if (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
                {
                    rc = JSON_RC__REWIND_REQUIRED ;
                }
            }

            if (rc != JSON_RC__REWIND_REQUIRED)
            {
                if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
                {
                    return (rc) ;
                }

                if (IsIntermediateSubsegment (&input_text))
                {
                    UpdateBestCaseRc (&rc , IncreaseNestingAccordingToEntry (&parser_nesting , *found_property)) ;
                    if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
                    {
                        return (rc) ;
                    }

                    UpdateHashAndArrayIndex (&hash , &array_index_32 , &parser_nesting) ;
                }
            }
        }
        else
        {
            return (JSON_RC__PARSING_FAILURE) ;
        }
    }

    if (parser_nesting.Stack[parser_nesting.Position - 1].IsArray)
    {
        *array_index = (uint16_t)array_index_32 ;
    }

    return (rc) ;
}

#endif
/*****************************************************************************/
json_rc_T    SkipPropertyTableEntry (_IO_ const uint8_t * *    property_table_position  ,
                                     _I_  skipping_mode_T    skipping_mode             )
{
    const property_table_entry_T *  property_table_entry        ;
    uint16_t                          value_size                  ;
    json_rc_T                       rc         = JSON_RC__OK    ;


    property_table_entry  = (const property_table_entry_T *)*property_table_position ;

    if (IS_SINGLE_VALUE (property_table_entry->Common.PropertyType))
    {
        UpdateBestCaseRc (&rc , DetermineValueSize (&value_size , property_table_entry->Common.PropertyType)) ;

        if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
        {
            return (rc) ;
        }

        *property_table_position += sizeof(property_table_entry->Common) + value_size ;
    }
    else
    {
        if (skipping_mode == SKIP_COMPLEX_OBJECTS)
        {
            *property_table_position += COMPLEX_OBJECT_LENGTH (property_table_entry->Common.PropertyType) ;
        }
        else if (IS_OBJECT (property_table_entry->Common.PropertyType))
        {
            *property_table_position += sizeof (property_table_entry->Common) ;
        }
        else
        {
            *property_table_position += sizeof (property_table_entry->Array) ;
        }
    }
 
    return (rc) ;
}
/*****************************************************************************/
json_rc_T   FindLastExplicitlySpecifiedMember (__O  const property_table_entry_T * *    default_member                   ,
                                               __O  uint16_t *                            default_member_size__unexpanded  ,
                                               _I_  property_table_entry__array_T *     array_ptr                         )
{
    const property_table_entry_T *  after_default_member ;
    uint8_t                           array_index          ;
    json_rc_T                       rc    = JSON_RC__OK  ;


    *default_member = (const property_table_entry_T *)((const uint8_t *)array_ptr + sizeof(*array_ptr)) ;

    for (array_index = 0  ;  array_index < array_ptr->MembersCount_ExpectedByTemplate - 1  ;  array_index++)
    {
        UpdateBestCaseRc (&rc , SkipPropertyTableEntry ((const uint8_t **)default_member , SKIP_COMPLEX_OBJECTS)) ;

        if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
        {
            return (rc) ;
        }
    }

    after_default_member = *default_member ;

    UpdateBestCaseRc (&rc , SkipPropertyTableEntry ((const uint8_t **)&after_default_member , SKIP_COMPLEX_OBJECTS)) ;

    UpdateBestCaseRc (&rc , CopyUnexpandedAndInvalidated (NULL , default_member_size__unexpanded , *default_member)) ;

    return (rc) ;
}
/*****************************************************************************/
json_rc_T    FindIndexIn_OrJustAfter_Array (_IO_ const property_table_entry_T * *  property_table_entry     ,
                                            _I_  uint16_t                            sought_array_index       ,
                                            _I_  expanding_array_behavior_T        expanding_array_behavior  )
{
    const uint8_t *                   property_table_position = (const uint8_t *)*property_table_entry + sizeof(property_table_entry__array_T) ;
    uint8_t                           array_members_count     = (*property_table_entry)->Array.MembersCount   ;
    const property_table_entry_T *  default_member_location__UNUSED               ;
    uint16_t                          default_member_size__unexpanded               ;
    uint16_t                          array_index                                   ;
    uint16_t                          array_index_target                            ;
    json_rc_T                       rc                      = JSON_RC__OK         ;


    rc = FindLastExplicitlySpecifiedMember (&default_member_location__UNUSED  ,
                                            &default_member_size__unexpanded  ,
                                            &(*property_table_entry)->Array    ) ;

    if (    (expanding_array_behavior == ARRAYS__KEEP_AS_IN_TEMPLATE)
        &&  (sought_array_index >= (*property_table_entry)->Array.MembersCount_ExpectedByTemplate))
    {
        array_index_target = (*property_table_entry)->Array.MembersCount_ExpectedByTemplate - 1 ;
    }
    else
    {
        array_index_target = sought_array_index ;
    }

    for (array_index = 0  ;  (array_index < array_index_target)  &&  (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)  ;  array_index++)
    {
        if (array_index < array_members_count)
        {
            UpdateBestCaseRc (&rc , SkipPropertyTableEntry (&property_table_position , SKIP_COMPLEX_OBJECTS)) ;
        }
        else
        {
            /*********************************************************/
            /* Keep skipping beyond the end of the array,            */
            /*   and point to where the sought array entry would be  */
            /*   in case the array is subsequently expanded.         */
            /*********************************************************/
            property_table_position += default_member_size__unexpanded ;
        }
    }
     
    *property_table_entry = (const property_table_entry_T *)property_table_position ;

    if (   (rc > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
        && (sought_array_index > array_members_count))
    {
        rc = JSON_RC__INDEX_FAR_BEYOND_ARRAY_END ;
    }
    
    return (rc) ;
}
/*****************************************************************************/
static json_rc_T    InterpretUnicodeHex (__O  int32_t *  unicode_value   ,
                                         _I_  char     hex_4_digits[4]  )
{
    char        uppercase_hex_digit ;
    int         i                   ;


    *unicode_value = 0L ;

    for (i = 0  ;  i < 4u  ;  i++)
    {
        *unicode_value <<= 4 ;

        uppercase_hex_digit = hex_4_digits[i] & ~0x20 ;

        if (hex_4_digits[i] < '0')
        {
            return (JSON_RC__PARSING_FAILURE__INCOMPLETE_STRING) ;
        }
        else if (hex_4_digits[i] <= '9')
        {
            *unicode_value |= hex_4_digits[i] - '0' ;
        }
        else if (uppercase_hex_digit < 'A')
        {
            return (JSON_RC__PARSING_FAILURE__INCOMPLETE_STRING) ;
        }
        else if (uppercase_hex_digit <= 'F')
        {
            *unicode_value |= uppercase_hex_digit - 'A' + 10 ;
        }
        else
        {
            return (JSON_RC__PARSING_FAILURE__INCOMPLETE_STRING) ;
        }
    }

    return (JSON_RC__OK) ;
}
/*****************************************************************************/
json_rc_T   GetCanonizedCharacter (__O  int32_t *    canonized_value  ,
                                   _IO_ uint16_t *   index_into_input  ,
                                   _I_  char       input_data[]      ,
                                   _I_  uint16_t     input_data_size    )
{
    json_rc_T      rc = JSON_RC__OK  ;



    *canonized_value = CANONIZED_VALUE__NOT_FOUND ;

    if (*index_into_input >= input_data_size)
    {
        return (JSON_RC__PARSING_FAILURE__INCOMPLETE_STRING) ;
    }

    if (input_data[*index_into_input] != '\\')
    {
        *canonized_value = input_data[*index_into_input] ;

        ++ *index_into_input ;   /* Skip character */

        return (JSON_RC__OK) ;
    }

    if (*index_into_input >= input_data_size - 1u)
    {
        return (JSON_RC__PARSING_FAILURE__INCOMPLETE_STRING) ;
    }

    ++ (*index_into_input) ;   /* Skip '\\' */

    switch (input_data[*index_into_input])
    {
        case 'b':   *canonized_value = '\b' ;      break ;
        case 'f':   *canonized_value = '\f' ;      break ;
        case 'n':   *canonized_value = '\n' ;      break ;
        case 'r':   *canonized_value = '\r' ;      break ;
        case 't':   *canonized_value = '\t' ;      break ;

        case 'u':   ++ *index_into_input ;  /* Skip 'u' */

                    if (*index_into_input + 4u >= input_data_size - 1u)
                    {
                        return (JSON_RC__PARSING_FAILURE__INCOMPLETE_STRING) ;
                    }

                    rc = InterpretUnicodeHex (canonized_value , &input_data[*index_into_input]) ;

                    if (rc < JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
                    {
                        return (rc) ;
                    }

                    index_into_input += 4 - 1 ;  /* 4 charaters were interpreted. "- 1" to account for common increment after the 'switch' */

                    *canonized_value |= CANONIZED_VALUE__UNICODE ;

                    break ;

        default:    *canonized_value = input_data[*index_into_input] ;      /* Just ignore the '\\' */
    }

    ++ *index_into_input ;

    return (rc) ;
}
_INLINE_  void   UpdateBestCaseRc (_IO_ json_rc_T *  best_case_rc  , 
                                   _I_  json_rc_T    new_rc         )
{
    if (new_rc < *best_case_rc)
    {
        /******************************************************************/
        /* Lower value is worse, so:  Allow best-case-scenario to worsen. */
        /******************************************************************/
        *best_case_rc = new_rc ;
    }
}
/*---------------------------------------------------------------------------*/
#if defined(ALLOW_PARSING__TEMPLATE)

_INLINE_  uint8_t     SizeOfTemplateEntry (_I_ uint16_t   property_type)
{
    if (IS_ARRAY (property_type))
    {
        return (sizeof(property_table_entry__array_T)) ;
    }
    else
    {
        return (sizeof(property_table_entry__common_T)) ;
    }
}

#endif /* defined(ALLOW_PARSING__TEMPLATE) */

/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
