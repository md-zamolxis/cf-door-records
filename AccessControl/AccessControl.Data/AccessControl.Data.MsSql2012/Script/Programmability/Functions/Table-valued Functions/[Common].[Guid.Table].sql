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
			O.[name]	= 'Guid.Table'))
	DROP FUNCTION [Common].[Guid.Table];
GO

CREATE FUNCTION [Common].[Guid.Table](@entities XML)
RETURNS TABLE 
AS
RETURN
(
	SELECT X.[Guid] FROM
	(
		SELECT LTRIM(X.[Entity].value('(text())[1]',	'UNIQUEIDENTIFIER')) [Guid]
		FROM @entities.nodes('/*/guid') X ([Entity])
	) X
)
GO
