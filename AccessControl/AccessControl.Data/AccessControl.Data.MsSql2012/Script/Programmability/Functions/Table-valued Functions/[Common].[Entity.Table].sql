SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF (EXISTS(
		SELECT * FROM [sys].[schemas]	S
		INNER JOIN	[sys].[objects]		O	ON	S.[schema_id]	= O.[schema_id]
		WHERE 
			S.[name]	= 'Common'	AND
			O.[type]	= 'IF'		AND
			O.[name]	= 'Entity.Table'))
	DROP FUNCTION [Common].[Entity.Table];
GO

CREATE FUNCTION [Common].[Entity.Table](@entity XML)
RETURNS TABLE 
AS
RETURN
(
	SELECT * FROM
	(
		SELECT X.[Entity].query('.') [Entity]
		FROM @entity.nodes('/*') X ([Entity])
	) X
)
GO
