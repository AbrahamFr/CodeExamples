
DECLARE @sql varchar(max);
SELECT @sql = Coalesce(@sql + ' UNION ALL ', '') +
    'Select '''+QuoteName(name)+''' as ''DatabaseName'',COUNT(UserName) as ''Access Count'' FROM '+QuoteName(name)+'.dbo.UserAudit WHERE DATEDIFF(DAY, RecordDate, GETDATE()) < 31    ' + CHAR(13)
FROM   sys.databases
where name NOT LIKE '%main%' AND name NOT LIKE '%meta%' AND name NOT LIKE '%template%' AND name LIKE 'FARM00%' ORDER BY name
EXEC (@sql);
