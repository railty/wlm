require 'test_helper'

class JobTest < ActiveSupport::TestCase
  test "daily report excel" do
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

  test "pricing guide" do
    excelFileName = 'test/fixtures/Week 02 Pricing Guide.xlsx'
    job = Job.uploadExcel(excelFileName, File.basename(excelFileName))
    output = job.perform
    puts job.job_type
    puts job.input
    puts output
    assert File.size(output) == File.size('test/fixtures/Week 02 Pricing Guide Output.xlsx')
  end

  test "download_stores_products" do
    ct = ActiveRecord::Base.connection.exec_query "select count(*) as ct from products_stores"
    puts ct[0]['ct']

    job = Job.download_stores_products
    job.perform

    ct = ActiveRecord::Base.connection.exec_query "select count(*) as ct from products_stores"
    puts ct[0]['ct']

    assert ct == 0
    #assert ct > 100000
  end

  test "delete all items" do
    ct1 = ActiveRecord::Base.connection.exec_query "select count(*) as ct from items"
    puts ct1[0]['ct']
    ct2 = ActiveRecord::Base.connection.exec_query "select count(*) as ct from wm_items"
    puts ct2[0]['ct']

    job = Job.delete_wm_items
    job.perform

    ct3 = ActiveRecord::Base.connection.exec_query "select count(*) as ct from items"
    ct3 = ct3[0]['ct']
    ct4 = ActiveRecord::Base.connection.exec_query "select count(*) as ct from wm_items"
    ct4 = ct4[0]['ct']

    assert ct3 == 0
    assert ct4 == 0
  end

  test 'upload and push items' do
    #jobs = Job.push_items(['OFC', 'ALP'])
    stores =['OFC', 'ALP']
    jobs = Job.push_items(stores)

    upload_job = jobs.shift
    assert jobs.length == stores.length

    output = upload_job.perform
    upload_job.output = output
    upload_job.save
    assert output == 'items uploaded:123'

    jobs.each do |job|
      output = job.perform
      job.output = output
      store = stores.shift
      assert output == "#{store} items pushed:456"
      job.save
    end
  end

end
