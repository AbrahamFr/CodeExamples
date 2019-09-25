-- Use Common Table Expresss (CTE) for recursive looping through data

                        WITH CTE AS
                        (
                          SELECT ScanGroupId, NULL AS ParentId FROM ScanGroups
                          WHERE ScanGroupId = @ScanGroupId
                          UNION ALL
                          SELECT sgsg.SubgroupId, ParentId FROM ScanGroupSubgroups sgsg
                          INNER JOIN CTE c
                            ON sgsg.ScanGroupId = c.ScanGroupId
                        )
                        SELECT DISTINCT ScanGroupId FROM CTE";
