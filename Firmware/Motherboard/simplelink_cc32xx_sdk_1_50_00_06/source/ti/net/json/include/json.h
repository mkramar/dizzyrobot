#ifndef _JSON_H_
#define _JSON_H_
//#############################################################################
//
//! \file   json.h
//!
//! \brief  Contains JSON library APIs
//
//
//  (C) Copyright 2017, Texas Instruments, Inc.
//#############################################################################
//**************************************************************************
//                      JSON SCENARIOS EXAMPLES
//**************************************************************************
// Create json from       | Parse the json and get | Parse the json, change
// scratch and build it   | its value              | its value and build it
// +--------------------+ | +--------------------+ | +--------------------+
// |Json_createTemplate | | |Json_createTemplate | | |Json_createTemplate |
// +--------------------+ | +--------------------+ | +--------------------+
//            |           |            |           |            |
//            v           |            v           |            v
// +--------------------+ | +--------------------+ | +--------------------+
// |Json_createObject   | | |Json_createObject   | | |Json_createObject   |
// +--------------------+ | +--------------------+ | +--------------------+
//            |           |            |           |            |
//            v           |            v           |            v
// +--------------------+ | +--------------------+ | +--------------------+
// |Json_setValue       | | |Json_parse          | | |Json_parse          |
// +--------------------+ | +--------------------+ | +--------------------+
//            |           |            |           |            |
//            v           |            v           |            v
// +--------------------+ | +--------------------+ | +--------------------+
// |Json_build          | | |Json_getValue       | | |Json_getValue       |
// +--------------------+ | +--------------------+ | +--------------------+
//            |           |            |           |            |
//            v           |            v           |            v
// +--------------------+ | +--------------------+ | +--------------------+
// |Json_destroyObject  | | |Json_destroyObject  | | |Json_setValue       |
// +--------------------+ | +--------------------+ | +--------------------+
//            |           |            |           |            |
//            v           |            v           |            v
// +--------------------+ | +--------------------+ | +--------------------+
// |Json_destroyTemplate| | |Json_destroyTemplate| | |Json_build          |
// +--------------------+ | +--------------------+ | +--------------------+
//                        |                        |            |
//                        |                        |            v
//                        |                        | +--------------------+
//                        |                        | |Json_destroyObject  |
//                        |                        | +--------------------+
//                        |                        |            |
//                        |                        |            v
//                        |                        | +--------------------+
//                        |                        | |Json_destroyTemplate|
//                        |                        | +--------------------+
//**************************************************************************
//*******************************************************
//                  INCLUDES
//*******************************************************
#include <stdlib.h>
#include <string.h>
#include "json_engine.h"
//*******************************************************
//                  DEFINES - CONSTS
//*******************************************************
typedef size_t handle;

#define JSON_DEFAULT_SIZE                       (1024u)
#define JSON_LIB_VERSION                        "1.0.0.0"   
//*******************************************************
//                      FUNCTION PROTOTYPES
//*******************************************************

//*****************************************************************************
//
//! \brief This function creates internal template from the
//!        the template text.
//! \param[out]      templateHandle - template handle
//! \param[in]       templateString - json template text
//! \param[in]       templateStringLen - json template text length
//!
//! \return on success JSON_RC__OK, 
//!			on failure negative error code. 
//! \warning It's user reponsibility to free the created template using
//!          Json_destroyTemplate (handle templateHandle);
//! \note
//! \code
//!  uint16_t ret;
//!  handle templateHandle1;
//!  char * templatestr = "{\"name\":string,\"age\":int32,\"cars models\":[string,string,string]};
//!  ret = Json_createTemplate(&templateHandle1,templatestr,strlen(templatestr));
//!  if (ret<0)
//!  {
//!    //error
//!  }
//!  \endcode
//!
//****************************************************************************
int16_t Json_createTemplate(handle *templateHandle, const char * templateString, uint16_t templateStringLen);


//*****************************************************************************
//
//! \brief This function free the internal template memory
//! \param[in]       templateHandle - template handle
//!
//! \return on success JSON_RC__OK, 
//!			on failure negative error code. 
//!
//! \sa     Json_createTemplate
//! \warning After destroying the template, the Json object will have a NULL
//!          pointer in it (see the object struct - jsonTemplateInternal_t *jsonTemplate).
//!          it's recommended to destroy first the Json object and only then the template.
//! \note
//! \code
//!  uint16_t ret;
//!  ret  = Json_destroyTemplate(templateHandle1);
//!  if (ret<0)
//!  {
//!      //error
//!  }
//!  \endcode
//!
//****************************************************************************
int16_t Json_destroyTemplate (handle templateHandle);


//*****************************************************************************
//
//! \brief This function creates an empty json object
//! \param[out]   objHandle - json object handle
//! \param[in]    templateHandle - json template handle
//! \paran[in]    maxObjectSize  - json object max size or 0 for default JSON_DEFAULT_SIZE
//!								 
//! \return on success JSON_RC__OK, 
//!			on failure negative error code. 
//!
//! \sa     Json_createTemplate
//! \warning 1.It's user reponsibility to free the created object using
//!          Json_destroyObject (handle objHandle);
//!          2.Creating a template before json object is mandatory.
//! \note
//! \code
//!  uint16_t ret;
//!  handle jsonObjHandle1;
//!  ret = Json_createObject(&jsonObjHandle1,templateHandle1,1024);
//!  if (ret<0)
//!  {
//!      //error
//!  }
//!  \endcode
//!
//****************************************************************************
int16_t Json_createObject(handle * objHandle , handle templateHandle, uint16_t maxObjectSize);

//*****************************************************************************
//
//! \brief This function free the internal json memory
//! \param[in]       objHandle - json object handle
//!
//! \return on success JSON_RC__OK, 
//!			on failure negative error code. 
//!
//! \sa     Json_createObject
//! \note
//! \code
//!  uint16_t ret;
//!  ret  = Json_destroyObject(jsonObjHandle1);
//!  if (ret<0)
//!  {
//!      //error
//!  }
//!  \endcode
//!
//****************************************************************************
int16_t Json_destroyObject (handle objHandle);


//*****************************************************************************
//
//! \brief This function converts the json text into internal representation
//! \param[in]      objHandle - json object handle
//! \param[in]      jsonText - pointer to the json text
//! \param[in]      jsonTextLen - json text size
//!
//! \return on success JSON_RC__OK, 
//!			on failure negative error code. 
//!
//! \sa     Json_createObject
//! \note
//! \code
//!  uint16_t ret;
//!  char * jsonBuf = "{\"name\":\"John\",\"age\":30,\"cars models\":[toyota,fiat,volvo]};
//!  ret = Json_parse(jsonObjHandle1,jsonBuf,strlen(jsonBuf));
//!  if (ret<0)
//!  {
//!      //error
//!  }
//! \endcode
//!
//****************************************************************************
int16_t Json_parse(handle objHandle, char * jsonText, uint16_t jsonTextLen);


//*****************************************************************************
//
//! \brief This function retrives the number of array elements in the provided key
//!
//! \paran[in]       objHandle - json object handle
//! \param[in]       pKey      - pointer to the key of the requested array, key must be null terminated
//!
//! \return on success number of array elements.
//!			on failure negative error code. 
//!
//! \sa     Json_parse
//! \note
//! \code
//!  uint16_t ret;
//!  uint16_t arrayCount;
//!  char * jsonBuf = "{\"name\":\"John\",\"age\":30,\"cars models\":[toyota,fiat,volvo]};
//!  char * key =  "\"car models\"";
//!  ret = Json_parse(jsonObjHandle1,jsonBuf,strlen(jsonBuf));
//!  if (ret<0)
//!  {
//!      //error
//!  }
//!  arrayCount = Json_getArrayMembersCount(jsonObjHandle1,key);
//!  if (arrayCount < 0)
//!     //error
//! \endcode
//!
//****************************************************************************
int16_t Json_getArrayMembersCount(handle objHandle, const char * pKey);


//*****************************************************************************
//
//! \brief This function retrieves value from json
//!
//! \param[in]      objHandle - json object handle
//! \param[in]      pKey - pointer to the key of the requested value , key must be null terminated
//! \param[out]     pValue - pointer to the retrieved value
//! \param[inout]   maxValueSize - on call maximum buffer size , return actuall buffer size
//!
//! \return on success JSON_RC__OK, 
//!			on failure negative error code. 
//!
//! \sa     Json_parse
//! \note
//! \code
//!  uint16_t ret;
//!  char * jsonBuf = "{\"name\":\"John\",\"age\":30,\"cars models\":[toyota,fiat,volvo]};
//!  char * key =  "\"name\"";
//!  char   value[5];
//!  uint16_t valueSize = 5;
//!  ret = Json_parse(jsonObjHandle1,jsonBuf,strlen(jsonBuf));
//!  if (ret<0)
//!  {
//!      //error
//!  }
//!  ret = Json_getValue(jsonObjHandle1,key,value,valueSize);
//!  if (ret<0)
//!  {
//!      //error
//!  }
//! \endcode
//!
//****************************************************************************
int16_t Json_getValue(handle objHandle , const char * pKey, void * pValue , uint16_t *maxValueSize);


//*****************************************************************************
//
//! \brief This function sets the value for the provided key
//!
//! \param[in]      objHandle - json object handle
//! \param[in]      pKey - pointer to the key of the value to be changed,  key must be null terminated
//! \param[in]      pValue - pointer to the value to be set
//! \param[in]      valueSize - size of the value
//!
//! \return on success JSON_RC__OK, 
//!			on failure negative error code. 
//!
//! \sa     Json_parse
//! \note
//! \code
//!  uint16_t ret;
//!  char * jsonBuf = "{\"name\":\"John\",\"age\":30,\"cars models\":[toyota,fiat,volvo]};
//!  char * key =  "\"age\"";
//!  uint16_r value = 29;
//!  uint16_t valueSize = sizeof(value);
//!  ret = Json_parse(jsonObjHandle1,jsonBuf,strlen(jsonBuf));
//!  if (ret<0)
//!  {
//!      //error
//!  }
//!  ret = Json_setValue(jsonObjHandle1,key,value,valueSize);
//!  if (ret<0)
//!  {
//!      //error
//!  }
//! \endcode
//!
//****************************************************************************
int16_t Json_setValue(handle objHandle, const char * pKey, void * pValue, uint16_t valueSize);


//*****************************************************************************
//
//! \brief This function builds the internal json into a text json
//!
//! \param[in]         objHandle - json object handle
//! \param[out]        pJsonText - pointer to buffer to output the json text
//! \param[inout]      maxTxtLen - on call maximum buffer size , output used buffer size
//!
//! \return on success JSON_RC__OK, 
//!			on failure negative error code. 
//!
//! \sa     Json_parse , Json_setValue
//! \note
//! \code
//!  uint16_t ret;
//!  char * key =  "\"age\"";
//!  uint16_r value = 29;
//!  uint16_t valueSize = sizeof(value);
//!  char builtBuff[100];
//!  uint16_t builtBuffSize = 100;
//!  ret = Json_setValue(jsonObjHandle1,key,value,valueSize);
//!  if (ret<0)
//!  {
//!      //error
//!  }
//!  ret = Json_build(jsonObjHandle1,builtBuf,&builtBuffSize);
//!  if (ret<0)
//!  {
//!      //error
//!  }
//! \endcode
//****************************************************************************
int16_t Json_build(handle objHandle, char *pJsonText, uint16_t *maxTxtLen);

#endif  /* end of _JSON_H_ */
