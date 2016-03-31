/****** Object:  StoredProcedure [dbo].[Print_Product_Label]    Script Date: 3/31/16 6:17:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
Create PROCEDURE [dbo].[Print_Product_Label]
	@Prod_Num varchar(15),
	@Location_Code Varchar(15) = ''
AS
BEGIN

	SET NOCOUNT ON;
	Delete From items_label Where UPC_GTIN = @Prod_Num;

	INSERT INTO items_label
   ([UPC_GTIN]
   ,[Item_Description_1]
   ,[Unit_Size_UOM]
   ,[Base_Unit_Retail]
   ,[Department]
   ,[Department_Name]
   ,[Country_of_Origin]
   ,[Country_of_Origin_Name]
   )
	Select
	[upc]
   ,Upper([item_desc_1])
   ,[unit_size_uom]
   ,[unit_retail]
   ,department_id
   ,departments.name
   ,origin
   ,[Country_NAME]
	From Items  join departments on department_id = departments.id join CountryCode On origin=CountryCode.Country_Code
	Where UPC = @Prod_Num;

	If @@ROWCOUNT = 1
	Begin

		UPDATE Items_Label SET Price_Per_Lb = '$'+ Convert(Varchar, Convert(Decimal(10, 2), Base_Unit_Retail/2.20462)) WHERE UPC_GTIN = @Prod_Num And unit_size_uom <> 'EA';

	End

	Select * From items_label Where UPC_GTIN = @Prod_Num;
	Return @@RowCount;
END
