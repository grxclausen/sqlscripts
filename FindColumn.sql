/**************************************************************
Name:       FindColumn.sql
Author:     Gary Clausen
Created On: 7/1/2014

Description: Quickly finds a column.
**************************************************************/
SELECT t.name AS table_name
    ,SCHEMA_NAME(schema_id) AS schema_name
    ,c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%Credit%'
ORDER BY schema_name, table_name;
