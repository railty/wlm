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
