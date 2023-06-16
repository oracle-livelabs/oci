```sql
    <copy>
     select 
    j."transcription"  
from apex_collections c, json_table(
    c.clob001 format json,
    '$.transcriptions[*]'
    columns (
        "transcription"      VARCHAR2(4000)  path '$.transcription' 
    )
) j
where c.collection_name = 'REST_COLLECTION' 
 
    </copy>
    ```