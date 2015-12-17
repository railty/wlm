system("rake wlm:start_office")
job = Item.importExcel('data/input/905818a_449662948_0F108F4FX5175X4EE4XAFB5XE0FD94DE1A27.xlsx')
system("rake wlm:stop_office")
##Item.generateJsonForMigration(job)
##Item.jsonToMigration('items')

Item.loadData(job)
