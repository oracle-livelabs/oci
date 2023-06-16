DECLARE

  l_url   varchar2(4000) := 'https://api.openai.com/v1/completions'; 
  l_input varchar2(4000) := :P38_INPUT;
  l_body  varchar2(4000) := '{
            "model": "text-davinci-003",
            "prompt": "'||l_input||'",
            "temperature": 0.7,
            "max_tokens": 256,
            "top_p": 1,
            "frequency_penalty": 0,
            "presence_penalty": 0
            }'; 
  l_response_json CLOB;
  l_text varchar2(4000);

  CURSOR C1  IS 
    SELECT jt.* 
    FROM   JSON_TABLE(l_response_json, '$' 
             COLUMNS (text VARCHAR2(2000)  PATH '$.choices[0].text' )) jt; 

BEGIN

if l_input is not null then

        apex_web_service.g_request_headers(1).name := 'Content-Type';
        apex_web_service.g_request_headers(1).value := 'application/json';
        apex_web_service.g_request_headers(2).name := 'Authorization';
        apex_web_service.g_request_headers(2).value := 'Bearer sk-your-openai-key';

        l_response_json := apex_web_service.make_rest_request( 
        p_url => l_url, 
        p_http_method => 'POST', 
        p_body => l_body  
        );
        

        For row_1 In C1 Loop
                l_text := row_1.text;
                Htp.p(  l_text );  
        End Loop;

    end if;

END;