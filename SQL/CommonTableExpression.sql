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
                        
                        
                        
 -- Alternative
			    WITH cteCheckPointGroupHierarchy AS
				(
					SELECT cpg.CheckpointGroupId, CAST(NULL AS nvarchar(32)) AS ParentId
					FROM CheckpointGroups cpg
					WHERE cpg.CheckpointGroupId = @CheckpointGroupID
						AND cpg.CheckpointGroupId NOT IN (Select SubGroupId FROM CheckpointGroupSubGroups)
					UNION ALL
					SELECT SubgroupId, cpgsg.CheckpointGroupId AS ParentId
					FROM CheckpointGroupSubGroups cpgsg
					INNER JOIN cteCheckPointGroupHierarchy c
						ON cpgsg.CheckpointGroupId = c.CheckpointGroupId
				)
				SELECT cpgcp.* FROM CheckpointGroupCheckpoints cpgcp
				INNER JOIN cteCheckPointGroupHierarchy cpgh
				  ON cpgh.CheckpointGroupId = cpgcp.CheckpointGroupId";
