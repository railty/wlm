-- =============================================
-- Author:		<Shawn Ning>
-- Create date: <March 3, 2011>
-- Description:	Calculate Inventory
-- =============================================
CREATE PROCEDURE [dbo].[PushItems](@store varchar(10), @rc varchar(250) out)
AS
BEGIN
declare @ct integer;
	SET NOCOUNT ON;

	WAITFOR DELAY '00:00:3';

	select rc = @store + ' items pushed:456' 
END
