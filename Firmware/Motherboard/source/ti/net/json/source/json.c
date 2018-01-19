//*******************************************************
//                  INCLUDES
//*******************************************************
#include "json.h"

//*******************************************************
//                  STRUCTs
//*******************************************************

typedef struct  {
    char *  pData;
    uint16_t len;
    uint32_t validNum;
}jsonTemplateInternal_t;


typedef struct {
    char *  jsonInternal;
    uint16_t  jsonInternalSize;
    uint16_t jsonInternalSizeMAX;
    jsonTemplateInternal_t *jsonTemplate;
    uint32_t validNum;
}jsonObjectInternal_t;


//*******************************************************
//                  DEFINES - CONSTS
//*******************************************************
/* Header needed in order to create template lib representation */
#define TEMPLATE_MIN_HEADER_SIZE                (12u)
#define VALIDATION_NUMBER                       (0xDEADFACE)

#define ARRAY_TO_OBJ_EXTRA_CHARS_NUM            (6)

extern int sprintf(char *str, const char *format, ...);

/* Utility function - In case input_text contains white spaces at the beginning, skip it */
void SkipWS (char ** input_text, uint16_t *length)
{
    uint32_t position = 0;

    while ((position < *length) && ( (*input_text)[position] <= ' '))
    {
        position++ ;
    }

    *length -= position;
    *input_text += position;
}

int16_t Json_createTemplate(handle *templateHandle, const char * templateString, uint16_t templateStringLen)
{
    json_rc_T rcode;
    uint16_t minimalTemplateSize = 0;
    jsonTemplateInternal_t *pInternalTemplate;

    pInternalTemplate = (jsonTemplateInternal_t *)(malloc(sizeof(jsonTemplateInternal_t)));
    if (pInternalTemplate)
    {
        pInternalTemplate->pData = (char *)malloc(TEMPLATE_MIN_HEADER_SIZE + templateStringLen);
        if (pInternalTemplate->pData)
        {
            pInternalTemplate->len = TEMPLATE_MIN_HEADER_SIZE + templateStringLen;
            /* Transforming templateString into lib internal representation */
            rcode = __JSON_Templetize (pInternalTemplate->pData, &pInternalTemplate->len, &minimalTemplateSize, templateString, templateStringLen);
            if (rcode == JSON_RC__OK)
            {
                /* Setting the validNum with validation number to validate the handle */
                pInternalTemplate->validNum = VALIDATION_NUMBER;
                /* Returning the template handle we created */
                *templateHandle = (handle)pInternalTemplate;
                return rcode;
            }
            else
            {
                free(pInternalTemplate->pData);
                free(pInternalTemplate);
                return rcode;
            }
        }
        free(pInternalTemplate);
        return JSON_RC__MEMORY_ALLOCATION_ERROR;
    }
    else
    {
        return JSON_RC__MEMORY_ALLOCATION_ERROR;
    }
}

int16_t Json_destroyTemplate (handle templateHandle)
{
    /* Validating template handle */
    if ((templateHandle != 0) && (((jsonTemplateInternal_t *)templateHandle)->validNum == VALIDATION_NUMBER))
    {
        jsonTemplateInternal_t *pInternalTemplate = (jsonTemplateInternal_t *)templateHandle;
        pInternalTemplate->pData = NULL;
        pInternalTemplate->len = 0;
        /* initialize magic number to 0 */
        pInternalTemplate->validNum = 0;
        free(pInternalTemplate->pData);
        free(pInternalTemplate);
        return JSON_RC__OK;
    }
    return JSON_RC__INVALID_TEMPLATE_HANDLE;
}

int16_t Json_createObject(handle * objHandle , handle templateHandle , uint16_t maxObjectSize)
{
    uint16_t  internalInitBuffSize;
    json_rc_T rcode;
    jsonObjectInternal_t * jsonObject;

    /* Validating template handle */
    if ((templateHandle != 0) && (((jsonTemplateInternal_t *)templateHandle)->validNum == VALIDATION_NUMBER))
    {
        if (maxObjectSize == 0)
        {
            maxObjectSize = JSON_DEFAULT_SIZE;
        }
        /* Filling the json object fields */
        jsonObject = (jsonObjectInternal_t *)(malloc(sizeof(jsonObjectInternal_t)));
        if (jsonObject)
        {
            jsonObject->jsonInternal = (char * )(malloc(maxObjectSize));
            jsonObject->jsonInternalSizeMAX = maxObjectSize;
            /* Setting the validNum with validation number to validate the handle */
            jsonObject->validNum = VALIDATION_NUMBER;
            jsonObject->jsonTemplate = (jsonTemplateInternal_t *)templateHandle;

            internalInitBuffSize = jsonObject->jsonInternalSizeMAX;
            /* Creates empty Json ready for filling */
            rcode = __JSON_Init (jsonObject->jsonInternal, &internalInitBuffSize, jsonObject->jsonTemplate->pData, jsonObject->jsonTemplate->len) ;
            if (rcode == JSON_RC__OK)
            {
                jsonObject->jsonInternalSize = internalInitBuffSize;
                /* Returning the Json object handle we created */
                *objHandle = (handle)jsonObject;
                return JSON_RC__OK;
            }
            return rcode;
        }
        return JSON_RC__MEMORY_ALLOCATION_ERROR;
    }
    return JSON_RC__INVALID_TEMPLATE_HANDLE;
}

int16_t Json_destroyObject (handle objHandle)
{
    /* Validating object handle */
    if ((objHandle != 0) && (((jsonObjectInternal_t *)objHandle)->validNum == VALIDATION_NUMBER))
    {
        jsonObjectInternal_t * pJsonInternal = (jsonObjectInternal_t *)objHandle;
        free(pJsonInternal->jsonInternal);
        /* initialize the validation number to 0 */
        pJsonInternal->validNum = 0;
        free(pJsonInternal);
        return JSON_RC__OK;
    }
    return JSON_RC__INVALID_OBJECT_HANDLE;
}

int16_t Json_parse(handle objHandle, char * jsonText, uint16_t jsonTextLen)
{
    json_rc_T rcode;
    char *ArrayToObj = NULL;
    /* Validating object handle */
    if ((objHandle != 0) && (((jsonObjectInternal_t *)objHandle)->validNum == VALIDATION_NUMBER))
    {
        jsonObjectInternal_t * pJsonInfo =  (jsonObjectInternal_t *) objHandle;
        /* Validating that the template pointer in the Json object is valid */
        if (pJsonInfo->jsonTemplate->validNum == VALIDATION_NUMBER)
        {
            uint16_t jsonInternalBuffSize = pJsonInfo->jsonInternalSizeMAX;

            /* In case the jsonText contains white spaces at the beginning, skip it */
            SkipWS (&jsonText, &jsonTextLen);

            /* In case the first char in the jsonText is "[", i.e., the jsonText is not a Json object, but a Json array, */
            /* convert the Json array to be a value of an object name "#" */
            if (jsonText[0] == '[')
            {
                /* 6 extra characters - {"#": [jsonText in array format] } */
                jsonTextLen+=ARRAY_TO_OBJ_EXTRA_CHARS_NUM;

                ArrayToObj = (char * )(malloc(jsonTextLen));
                if (ArrayToObj != NULL)
                {
                    memset(ArrayToObj, 0, jsonTextLen);
                    /* convert the Json array to be a value of an object name "#" */
                    sprintf(ArrayToObj, "{\"#\":%s}",jsonText);
                    jsonText =  ArrayToObj;
                }
                else
                {
                    return JSON_RC__MEMORY_ALLOCATION_ERROR;
                }
            }

            /* Parsing the json text and filling the internal lib representation */
            rcode = __JSON_Parse(pJsonInfo->jsonInternal,&jsonInternalBuffSize,jsonText,jsonTextLen,pJsonInfo->jsonTemplate->pData ,pJsonInfo->jsonTemplate->len , 0);

            if (ArrayToObj != NULL)
            {
                free(ArrayToObj);
            }

            if (rcode > JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
            {
                /* Update current json internal representation size */
                pJsonInfo->jsonInternalSize = jsonInternalBuffSize;
                return JSON_RC__OK;
            }
            else
            {
                return rcode;
            }
        }
        return JSON_RC__INVALID_TEMPLATE_HANDLE;
    }
    return JSON_RC__INVALID_OBJECT_HANDLE;
}

int16_t Json_getArrayMembersCount(handle objHandle, const char * pKey)
{
    json_rc_T rcode;
    uint16_t count;
    /* Validating object handle */
    if ((objHandle != 0) && (((jsonObjectInternal_t *)objHandle)->validNum == VALIDATION_NUMBER))
    {
        jsonObjectInternal_t * pJsonInfo  = (jsonObjectInternal_t *)objHandle;
        uint16_t keySize = strlen(pKey);
        /* Return wanted array members count */
        rcode = __JSON_GetArrayMembersCount (&count,pJsonInfo->jsonInternal , pKey, keySize);
        if (rcode == JSON_RC__OK)
        {
            /* In case of success return the array count */
            return count;
        }
        return rcode;
    }
    return JSON_RC__INVALID_OBJECT_HANDLE;
}

int16_t Json_getValue(handle objHandle , const char * pKey, void * pValue , uint16_t *maxValueSize)
{
    json_rc_T rcode;
    /* Validating object handle */
    if ((objHandle != 0) && (((jsonObjectInternal_t *)objHandle)->validNum == VALIDATION_NUMBER))
    {
        jsonObjectInternal_t * pJsonInfo = (jsonObjectInternal_t *) objHandle;
        uint16_t keySize = strlen(pKey);
        /* Retrieves wanted value */
        rcode = __JSON_GetValue(pValue, maxValueSize, pJsonInfo->jsonInternal, pKey, keySize) ;
        return rcode;
    }
    return JSON_RC__INVALID_OBJECT_HANDLE;
}

int16_t Json_setValue(handle objHandle, const char * pKey, void * pValue, uint16_t valueSize)
{
    uint16_t usedSize;
    json_rc_T rcode;
    uint16_t keySize = strlen(pKey);
    /* Validating object handle */
    if ((objHandle != 0) && (((jsonObjectInternal_t *)objHandle)->validNum == VALIDATION_NUMBER))
    {
        jsonObjectInternal_t * pJsonInfo = (jsonObjectInternal_t *)objHandle;
        usedSize = pJsonInfo->jsonInternalSizeMAX;
        /* Set new value into the wanted key */
        rcode = __JSON_SetValue (pJsonInfo->jsonInternal, &usedSize, pValue, valueSize, pKey ,keySize) ;
        if (rcode==JSON_RC__OK)
        {
            /* Updating Json lib representation size after setting the new value */
            pJsonInfo->jsonInternalSize = usedSize ;
            return JSON_RC__OK;
        }
        return rcode;
    }
    return JSON_RC__INVALID_OBJECT_HANDLE;
}

int16_t Json_build(handle objHandle, char *pJsonText, uint16_t *maxTxtLen)
{
    json_rc_T rcode;
    /* Validating object handle */
    if ((objHandle != 0) && (((jsonObjectInternal_t *)objHandle)->validNum == VALIDATION_NUMBER))
    {
        jsonObjectInternal_t * pJsonInfo =(jsonObjectInternal_t *) objHandle;
        /* Validating that the template pointer in the Json object is valid */
        if (pJsonInfo->jsonTemplate->validNum == VALIDATION_NUMBER)
        {
            /* Building Json into text string */
            rcode = __JSON_Build (pJsonText, maxTxtLen, pJsonInfo->jsonInternal, pJsonInfo->jsonTemplate->pData) ;
            if (rcode>= JSON_RC__RECOVERABLE_ERROR__MINIMUM_VALUE)
            {
                /* Making the text null terminated */
                pJsonText[*maxTxtLen] =  '\0';
                return JSON_RC__OK;
            }
            else
            {
            return rcode;
            }
        }
        return JSON_RC__INVALID_TEMPLATE_HANDLE;
    }
    return JSON_RC__INVALID_OBJECT_HANDLE;
}
