-- Use instead of Temp tables for more functional programming
-- https://odetocode.com/Articles/365.aspx

		                DECLARE @LicensedCheckpointGroups TABLE (
			                CheckpointGroupId nvarchar(32),
			                ShortDescription varchar(max)
		                )
                        INSERT INTO @LicensedCheckpointGroups 
                        SELECT * FROM udfGetLicensedCheckpointGroups(@LicensedModules)
		                Select DISTINCT cpbcpg.CheckpointId FROM [dbo].[udf_GetCheckpointsByCheckpointGroup](@CheckpointGroupId) cpbcpg
                        INNER JOIN [dbo].[udfCheckpointsByPermission](@UserGroupId, 'Checkpoint') cpbp
                            ON cpbp.CheckpointId = cpbcpg.CheckpointId
                        INNER JOIN @LicensedCheckpointGroups lcpg
			                ON cpbcpg.CheckpointGroupId = lcpg.CheckpointGroupId				  						  
                        INNER JOIN [dbo].[udfCheckpointGroupsByPermission](@UserGroupId, 'CheckpointGroup') cpgbp
                            ON lcpg.CheckpointGroupId = cpgbp.CheckpointGroupId";
