-- =============================================
-- Author:		<Shawn Ning>
-- Create date: <March 3, 2011>
-- Description:	Calculate Inventory
-- =============================================
CREATE PROCEDURE [dbo].[CreateAndDownloadProductsStores]
AS
BEGIN
declare @ct integer;
	SET NOCOUNT ON;

	WAITFOR DELAY '00:00:12';

	select @ct = 123;
	return @ct;
END
