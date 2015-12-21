excel = ARGV[0]

system("rake wlm:start_office")
job = Item.importExcel(excel)
system("rake wlm:stop_office")
##Item.generateJsonForMigration(job)
##Item.jsonToMigration('items')

Item.loadData(job)
