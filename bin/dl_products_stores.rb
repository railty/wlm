ct = ActiveRecord::Base.connection.execute_procedure 'dbo.Create_And_Download_Products_Stores'
ct = ct[0][0]['']
puts ct

sql = "SELECT id as WM, unit_retail as Current_Price, Store, Prod_Name, Prod_Alias, RegPrice, OnSalePrice FROM items join products_stores on items.vendor_stk_nbr=products_stores.prod_num"
rs = ActiveRecord::Base.connection.select_all(sql)
wms = {}
rs.each do |r|
  wms[r['WM']] = r
end

File.open("data/output/wms.json", "w") do |f|
  f.write(JSON.pretty_generate(wms))
end
