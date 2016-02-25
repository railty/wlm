-- =============================================
-- Author:		<Shawn Ning>
-- Create date: <March 3, 2011>
-- Description:	<Import Data from another (older) database>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteWmItemsAndItems](@rc varchar(250) out)
AS
BEGIN
	SET NOCOUNT ON;
	declare @ct1 int;
	declare @ct2 int;
	delete from items;
	select @ct1 = @@rowcount
	delete from wm_items;
	select @ct2 = @@rowcount
	select rc = 'items deleted:' + cast(@ct1 as varchar(6)) + ', wm_items deleted:' + cast(@ct2 as varchar(6))
END
