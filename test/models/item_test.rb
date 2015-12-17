require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "import excel file" do
    x = Item.importExcel('test/fixtures/daily.xlsx', 1234)
    assert x == 5334
  end

  test "load data" do
    x = Item.loadData(1234)
    assert x == 1
  end

  test "json to migration" do
    x = Item.jsonToMigration('items')
    assert x == 1
  end

end
