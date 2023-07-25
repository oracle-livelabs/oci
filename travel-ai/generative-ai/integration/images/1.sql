DECLARE
    l_response_clob         CLOB;
    l_rest_url              VARCHAR2(1000);
    l_token_url             VARCHAR2(1000);
    l_count_posted          PLS_INTEGER; 
    l_type VARCHAR2(100); 
    l_returnDate VARCHAR2(100);
    l_total NUMBER;
    l_locations VARCHAR2(100); 
    l_origin VARCHAR2(100) := :P28_ORIGIN; --- 'MAD'
    l_destination VARCHAR2(100) := :P28_DESTINATION ; -- 'LON' 
    -- You can use Date picker variable
    l_departureDate varchar2(100) := '2023-09-09'; 
    fid FLIGHTDATA.fid%TYPE; 

    CURSOR C1  IS 
    SELECT jt.* 
    FROM   JSON_TABLE(l_response_clob, '$.data[*]'  
    COLUMNS  
        (l_type VARCHAR2(100) PATH '$.type',
         l_departureDate VARCHAR2(100) PATH '$.departureDate',
         l_returnDate VARCHAR2(100) PATH '$.returnDate',
         l_total number PATH '$.price[0].total'  )
    ) jt; 
     
BEGIN
 
  l_rest_url  := 'https://test.api.amadeus.com/v1/shopping/flight-dates?origin='||l_origin||'&destination='||l_destination||'&departureDate='||l_departureDate||'';
  l_token_url := 'https://test.api.amadeus.com/v1/security/oauth2/token';
 
  apex_web_service.g_request_headers.DELETE; 
  apex_web_service.g_request_headers(1).name  := 'Content-Type'; 
  apex_web_service.g_request_headers(1).value := 'application/json'; 
   
  l_response_clob := apex_web_service.make_rest_request 
   (p_url                  => l_rest_url, 
    p_http_method          => 'GET',  
    p_credential_static_id => 'AmadeusAuth',
    p_token_url            => l_token_url ); 
    
    -- Use a temporary table to store flight price data and retrieve it back in the page 
    DELETE FROM FLIGHTDATA;
    For row_1 In C1 Loop
        l_type := row_1.l_type;
        l_departureDate := row_1.l_departureDate;
        l_returnDate := row_1.l_returnDate;
        l_total := row_1.l_total;   
        INSERT INTO FLIGHTDATA (Origin, Destination, DepartureDate, ReturnDate, price ) 
        VALUES (l_origin, l_destination, to_char(to_date(l_departureDate,'yy-MM-dd')),to_char(to_date(l_returnDate,'yy-MM-dd')), l_total);   
    End Loop;     
 
    IF apex_web_service.g_status_code != 200 then 
        raise_application_error(-20112,'Unable to call OCI Flight Price Service.');  
    END IF; 
    
 
END;