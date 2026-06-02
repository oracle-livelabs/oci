CREATE OR REPLACE FUNCTION EXECUTE_SQL(
    query  IN CLOB,
    offset IN NUMBER,
    limit  IN NUMBER
) RETURN CLOB
AS
    v_sql  CLOB;
    v_json CLOB;
BEGIN
    v_sql := 'SELECT NVL(JSON_ARRAYAGG(JSON_OBJECT(*) RETURNING CLOB), ''[]'') AS json_output ' ||
             'FROM ( SELECT * FROM ( ' || query || ' ) sub_q ' ||
             'OFFSET :off ROWS FETCH NEXT :lim ROWS ONLY )';

    EXECUTE IMMEDIATE v_sql INTO v_json USING offset, limit;
    RETURN v_json;
END;
/

BEGIN
  DBMS_CLOUD_AI_AGENT.CREATE_TOOL(
    tool_name  => 'EXECUTE_SQL',
    attributes => '{
      "instruction": "Run given read-only SQL query against the oracle database.",
      "function": "EXECUTE_SQL",
      "tool_inputs": [
        {"name":"query","description":"SELECT SQL statement without trailing semicolon."},
        {"name":"offset","description":"Rows to skip."},
        {"name":"limit","description":"Maximum rows to return."}
      ]
    }'
  );
END;
/
