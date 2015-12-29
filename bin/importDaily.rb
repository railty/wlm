excel = ARGV[0]

##Item.generateJsonForMigration(job)
##Item.jsonToMigration('items')

Item.loadData(Item.importExcel(excel))
