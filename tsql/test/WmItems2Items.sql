-- =============================================
-- Author:		<Shawn Ning>
-- Create date: <March 3, 2011>
-- Description:	<Import Data from another (older) database>
-- =============================================
CREATE PROCEDURE [dbo].[WmItems2Items]
AS
BEGIN
	SET NOCOUNT ON;

	--delete items from items left join wm_items on items.id = wm_items.Item_Nbr where wm_items.Item_Nbr is null
	set identity_insert items on
	insert into items ([id],[department_id],[upc],[vnpk_upc],[price_ceiling],[unit_cost],[unit_size],[unit_size_uom],[signing_desc],[vnpk_qty],[item_flags],[item_desc_1],[vendor_stk_nbr],[size_desc],[fineline_number],[fineline_description],[vnpk_cost],[owner],[created_at],[updated_at])
	select wi.[Item_Nbr],wi.[Acct_Dept_Nbr],wi.[UPC],wi.[VNPK_UPC],wi.[Unit_Retail],wi.[Unit_Cost],wi.[Unit_Size],wi.[Unit_Size_UOM],wi.[Signing_Desc],wi.[VNPK_Qty],wi.[Item_Flags],wi.[Item_Desc_1],wi.[Vendor_Stk_Nbr],wi.[Size_Desc],wi.[Fineline_Number],wi.[Fineline_Description],wi.[VNPK_Cost],[Source],GETDATE(), GETDATE()
	from items i right join wm_items wi on i.id = wi.Item_Nbr where i.id is null
	set identity_insert items off

	update i set
	i.[department_id]=wi.[Acct_Dept_Nbr],
	i.[upc]=wi.[UPC],
	i.[vnpk_upc]=wi.[VNPK_UPC],
	i.[unit_cost]=wi.[Unit_Cost],
	i.[unit_size]=wi.[Unit_Size],
	i.[unit_size_uom]=wi.[Unit_Size_UOM],
	i.[signing_desc]=wi.[Signing_Desc],
	i.[vnpk_qty]=wi.[VNPK_Qty],
	i.[item_flags]=wi.[Item_Flags],
	i.[item_desc_1]=wi.[Item_Desc_1],
	i.[vendor_stk_nbr]=wi.[Vendor_Stk_Nbr],
	i.[size_desc]=wi.[Size_Desc],
	i.[fineline_number]=wi.[Fineline_Number],
	i.[fineline_description]=wi.[Fineline_Description],
	i.[price_ceiling]=wi.[Unit_Retail],
	i.[vnpk_cost]=wi.[VNPK_Cost],
	i.[owner]=wi.[Source],
	i.[updated_at]=getdate()
	from items i join wm_items wi on i.id = wi.Item_Nbr

	update items set unit_retail = 0 where unit_retail is null;

	set identity_insert departments on
	delete from departments;
	insert into departments(id, name, created_at, updated_at)
	select distinct Acct_Dept_Nbr, Dept_Desc, GETDATE(), GETDATE() from wm_items;
	set identity_insert departments off

END
