create or replace PACKAGE IMAGE_AI_PK AS 
------------------------------------------------------------------------------- 
-- NAME        : IMAGE_AI_PK 
-- FILE NAME   : IMAGE_AI_PK.sql  
-- Author   19-Mar-2023  Madhusudhan Rao for IMAGE AI Service. 
------------------------------------------------------------------------------- 
  
  GC_WC_CREDENTIAL_ID        CONSTANT VARCHAR2(50)   := 'Ind_OCI_WebCred';  
   
  --- Dynamic variables ---------
  v_GC_OCI_OBJ_STORE_BASE_URL  MACHINE_LEARNING_CONFIGS.GC_OCI_OBJ_STORE_BASE_URL%TYPE;
  v_GC_OCI_DOC_AI_URL          MACHINE_LEARNING_CONFIGS.GC_OCI_DOC_AI_URL%TYPE;
  v_GC_OCI_DOC_AI_TIMEOUT_SECS  MACHINE_LEARNING_CONFIGS.GC_OCI_DOC_AI_TIMEOUT_SECS%TYPE;
  v_GC_WC_CREDENTIAL_ID  MACHINE_LEARNING_CONFIGS.GC_WC_CREDENTIAL_ID%TYPE;
  v_GC_OCI_REQ_AI_PAYLOAD MACHINE_LEARNING_CONFIGS.GC_OCI_REQ_AI_PAYLOAD%TYPE;
  --PROCEDURE initialize;
 
   
 GC_OCY_DOC_AI_PAYLOAD      CONSTANT VARCHAR2(32000) := '{
  "compartmentId": "ocid1.compartment.oc1..aaaaaaaaud6tkdn6n23cbvc4hexs6n4hggetkwo4viqyneyroixcmj54u32q",
  "image": {
    "source": "OBJECT_STORAGE",
    "namespaceName": "oradbclouducm",
    "bucketName": "X-Ray-Images-Staging",
    "objectName": "ImageAI/#FILE_NAME#"
  },
  "features": [
    {
      "modelId": "ocid1.aivisionmodel.oc1.phx.amaaaaaaknuwtjiaknai2cp5dioyg2f6rey4nahv6liheupktfthw3gakucq",
      "featureType": "IMAGE_CLASSIFICATION",
      "maxResults": 5
    }
  ]
}'; 

PROCEDURE process_file 
  (p_apex_file_name  IN VARCHAR2, 
   v_id IN MACHINE_LEARNING_CONFIGS.ID%TYPE,
   x_document_id    OUT cndemo_document_ai_docs.document_id%TYPE); 
 
PROCEDURE render_document 
  (x_document_id  IN cndemo_document_ai_docs.document_id%TYPE); 
   
END IMAGE_AI_PK; 
