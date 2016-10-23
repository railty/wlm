insert into alp_items(store_id, code, name, alias, description, package_spec, department, price, sale_price, onsale, updated_at, created_at, changed_at)
select 39 as store, Prod_Num as code, Prod_Name as name,
Prod_Alias as alias, prod_desc as description,
PackageSpec as package_spec, Department, RegPrice as price, OnsalePrice as sale_price, OnSales as onsale, GETDATE() as updated_at, GETDATE() as created_at,
dbo.LatestTime(p.modtimestamp, pp.modtimestamp)
from alp_pos.mbposdb.dbo.product p join alp_pos.mbposdb.dbo.productprice pp
on p.Prod_Num = pp.ProdNum
where Department in ('Fruit', 'Vegetable');

--------------------
/****** Object:  UserDefinedFunction [dbo].[LatestTime]    Script Date: 6/17/2016 12:16:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[LatestTime](@TmStr1 varchar(14), @TmStr2 varchar(14))
RETURNS Datetime
BEGIN
Declare @Str1 varchar(20);
Declare @Tm1 Datetime;
Declare @Str2 varchar(20);
Declare @Tm2 Datetime;
	Select @Str1 = SubString(@TmStr1, 1, 4) + '-' + SubString(@TmStr1, 5, 2) + '-' + SubString(@TmStr1, 7, 2) + ' ' + SubString(@TmStr1, 9, 2) + ':00:00';
	Select @Str2 = SubString(@TmStr2, 1, 4) + '-' + SubString(@TmStr2, 5, 2) + '-' + SubString(@TmStr2, 7, 2) + ' ' + SubString(@TmStr2, 9, 2) + ':00:00';
	if isdate(@str1) = 1  Select @Tm1 = Convert(Datetime, @Str1, 120) else Select @Tm1 = Convert(Datetime, '2000-01-01 00:00:00', 120);
	if isdate(@str2) = 1  Select @Tm2 = Convert(Datetime, @Str2, 120) else Select @Tm2 = Convert(Datetime, '2000-01-01 00:00:00', 120);

	IF @Tm1>@Tm2 return @Tm1
	return @Tm2
END
-----------------------------------------



delete from alp_items where store_id = 39;
insert into alp_items(store_id, code, name, alias, description, package_spec, department, price, sale_price, onsale, updated_at, created_at)
select 39 as store, Prod_Num as code, Prod_Name as name,
Prod_Alias as alias, prod_desc as description,
PackageSpec as package_spec, Department, RegPrice as price, OnsalePrice as sale_price, OnSales as onsale, GETDATE() as updated_at, GETDATE() as created_at
from alp_pos.mbposdb.dbo.product p join alp_pos.mbposdb.dbo.productprice pp
on p.Prod_Num = pp.ProdNum
where Department in ('Fruit', 'Vegetable');

delete from alp_items where store_id = 2;
insert into alp_items(store_id, code, name, alias, description, package_spec, department, price, sale_price, onsale, updated_at, created_at)
select 2 as store, Prod_Num as code, Prod_Name as name,
Prod_Alias as alias, prod_desc as description,
PackageSpec as package_spec, Department, RegPrice as price, OnsalePrice as sale_price, OnSales as onsale, GETDATE() as updated_at, GETDATE() as created_at
from ofc_pos.mbposdb.dbo.product p join ofc_pos.mbposdb.dbo.productprice pp
on p.Prod_Num = pp.ProdNum
where Department in ('Fruit', 'Vegetable');


delete from alp_items where store_id = 5;
insert into alp_items(store_id, code, name, alias, description, package_spec, department, price, sale_price, onsale, updated_at, created_at)
select 5 as store, Prod_Num as code, Prod_Name as name,
Prod_Alias as alias, prod_desc as description,
PackageSpec as package_spec, Department, RegPrice as price, OnsalePrice as sale_price, OnSales as onsale, GETDATE() as updated_at, GETDATE() as created_at
from ohs_pos.mbposdb.dbo.product p join ohs_pos.mbposdb.dbo.productprice pp
on p.Prod_Num = pp.ProdNum
where Department in ('Fruit', 'Vegetable');

delete from alp_items where store_id = 7;
insert into alp_items(store_id, code, name, alias, description, package_spec, department, price, sale_price, onsale, updated_at, created_at)
select 7 as store, Prod_Num as code, Prod_Name as name,
Prod_Alias as alias, prod_desc as description,
PackageSpec as package_spec, Department, RegPrice as price, OnsalePrice as sale_price, OnSales as onsale, GETDATE() as updated_at, GETDATE() as created_at
from ofmm_pos.mbposdb.dbo.product p join ofmm_pos.mbposdb.dbo.productprice pp
on p.Prod_Num = pp.ProdNum
where Department in ('Fruit', 'Vegetable');


select store_id, count(*) from alp_items group by store_id
