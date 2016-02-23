require 'test_helper'

class JobTest < ActiveSupport::TestCase
  test "upload excel" do
    Item.destroy_all
    WmItem.destroy_all

    excelFileName = 'test/fixtures/DAILY REPORT 02042016 - special.xlsx'
    job = Job.uploadExcel(excelFileName, File.basename(excelFileName))
    job.perform
    assert Item.all.length == 5609
    assert WmItem.all.length == 5609

    excelFileName = 'test/fixtures/hwadiwa_455472293_C15EDC7DXB3E9X402DXB164X91C98F856D85.xls'
    job = Job.uploadExcel(excelFileName, File.basename(excelFileName))
    job.perform
    assert Item.all.length == 6654
    assert WmItem.all.length == 6654
  end
end
