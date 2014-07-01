/**************************************************************
Name:       FixUntrustedConstraints.sql
Author:     Gary Clausen
Created On: 7/1/2014

Description: Searches databases for FKs and check constraints
             that are not trusted.
             Run against each database to check.
**************************************************************/
SELECT '[' + s.name + '].[' + o.name + '].[' + i.name + ']' AS KeyName 
    ,'[' + s.name + '].[' + o.name + ']'				AS SchemaTableName
    ,'[' + i.name + ']'								AS ConstraintName
    ,'ALTER TABLE ' + s.name + '.' + o.name + ' WITH CHECK CHECK CONSTRAINT ' + i.name AS Script
from sys.foreign_keys i 
INNER JOIN sys.objects o ON i.parent_object_id = o.object_id 
INNER JOIN sys.schemas s ON o.schema_id = s.schema_id 
WHERE i.is_not_trusted = 1 AND i.is_not_for_replication = 0 

SELECT '[' + s.name + '].[' + o.name + '].[' + i.name + ']'		AS KeyName 
     ,'[' + s.name + '].[' + o.name + ']'				     AS SchemaTableName
      ,'[' + i.name + ']'								AS ConstraintName
      ,'ALTER TABLE ' + s.name + '.' + o.name + ' WITH CHECK CHECK CONSTRAINT ' + i.name AS Script
from sys.check_constraints i 
INNER JOIN sys.objects o ON i.parent_object_id = o.object_id 
INNER JOIN sys.schemas s ON o.schema_id = s.schema_id 
WHERE i.is_not_trusted = 1 AND i.is_not_for_replication = 0 AND i.is_disabled = 0 
