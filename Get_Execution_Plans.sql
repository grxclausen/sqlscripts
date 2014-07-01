/**************************************************************
Name:       GetExecutionPlans.sql
Author:     Gary Clausen
Created On: 7/1/2014

Description: Gets execution plans and generates statement to
             remove single plans from cache.
             
             NOTE: Use caution when running this on production 
             servers. 
**************************************************************/
SELECT cp.refcounts
    ,cp.usecounts
    ,cp.objtype
    ,st.dbid
    ,st.objectid
    ,st.text
    ,qp.query_plan
    ,cp.plan_handle
    ,'DBCC FREEPROCCACHE (0x' + CONVERT(VARCHAR(MAX), cp.plan_handle, 2) + ')'  --CONVERT(varchar(max),@varbinaryField,2), 
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
WHERE objtype = 'Adhoc'
