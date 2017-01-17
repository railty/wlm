class Job < ActiveRecord::Base
  before_destroy :destroy_files

  def self.uploadExcel(originalExcelFile, originalExcelFileName)
    job = Job.new
    job.save
    ext = File.extname(originalExcelFileName)
    excelFile = "data/input/#{job.id}#{ext}"
    FileUtils::copy(originalExcelFile, excelFile)
    job.input = excelFile

    if originalExcelFileName =~ /^Daily Report /i then
      job.name = 'Import ALP Report'
      job.job_type = 'import_alp_products'
    elsif originalExcelFileName =~ /^hwadiwa_/i then
      job.name = 'Import WM Report'
      job.job_type = 'import_wm_products'
    elsif originalExcelFileName =~ /Pricing Guide/i then
      job.name = 'Create Pricing Guide'
      job.job_type = 'pricing_guide'
    #elsif originalExcelFileName =~ /Store (\d+) Sales (.*) Dept (.*)\.xlsx/i then
    #  store = $1
    #  dt = $2
    #  dept = $3
    #  job.name = 'Import Sales Report'
    #  job.job_type = 'weekly_sales_report'
  elsif originalExcelFileName =~ /Store (\d+) Sales (\w+) (\d+)\s*-\s*(\d+) (\d+) Dept (.*)\.xlsx/i then
      store = $1
      dept = $6
      dt = "#{$2} #{$3} #{$5}"
      dt = Date.parse(dt).strftime("%Y-%m-%d")

      job.name = "Import Daily Sales Report #{store} #{dt}"
      job.job_type = 'daily_sales_report'
    else
      job.job_type = 'unknown excel'
    end
    job.save
    job.enqueue
    return job
  end

  def perform
    if self.job_type == 'import_alp_products' or self.job_type == 'import_wm_products' then
      excelFile = self.input
      data = excelToAoA(excelFile)
      items = nil
      if self.job_type == 'import_alp_products' then
        mapping = JSON.parse(File.read("db/migrate/import_alp_products.json"))
        items = translate(data, mapping)
        items.each do |item|
          item['Source'] = 'ALP'
        end
      else
        mapping = JSON.parse(File.read("db/migrate/import_wm_products.json"))
        items = translate(data, mapping)

        items.each do |item|
          item['Acct_Dept_Nbr'] = 94
          item['Dept_Desc'] = 'PRODUCE'
          item['Source'] = 'WM'
        end
      end
      iInsert = 0
      iUpdate = 0
      iInsert, iUpdate = create_or_update_items(items) if items != nil
      ActiveRecord::Base.connection.execute_procedure 'dbo.WmItems2Items'
      return "inserted: #{iInsert}, updated: #{iUpdate}"
    elsif self.job_type == 'pricing_guide' then
      conn = Item.connection_config
      connstr = "#{conn[:host]}:#{conn[:port]}:#{conn[:database]}:#{conn[:username]}:#{conn[:password]}"
      output = "data/output/#{self.id}.xlsx"
      require 'open3'
      cmd = "pyoo/priceGuide.py #{self.input} #{output} #{connstr}"
      logger.info cmd
      Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        self.stdout = stdout.read
        self.stderr = stderr.read
      end
      return output
    elsif self.job_type == 'weekly_sales_report' then
      excelFile = self.input
      data = excelToAoA(excelFile)
      title = data['sheet'][0][1]
      if title =~ /(\d+) sales (\w+) (\d+) - (\d+) (\d+)/ then
        store = $1
        date = $2 + ' ' + $3 + ' ' + $5
        mapping = JSON.parse(File.read("db/migrate/import_wm_sales_weekly.json"))
        sales = translate(data, mapping)
        sales.each do |sale|
          sql = "insert into POS_Sales(Date, Product_ID, Quantity, Amount) values('#{date}', #{sale['Product_ID']}, #{sale['Quantity']}, #{sale['Amount']})"
          #puts sql
          rc = ActiveRecord::Base.connection.execute(sql)
        end
      end
    elsif self.job_type == 'daily_sales_report' then
      excelFile = self.input
      data = excelToAoA(excelFile)
      title = self.name
      if title =~ /Import Daily Sales Report (\d+) ([\d-]+)/ then
        store = $1
        date = Date.parse($2)

        mapping_base = JSON.parse(File.read("db/migrate/import_wm_sales_daily.json"))
        mapping = {'Item Nbr' => mapping_base["Item Nbr"].clone}
        (0 .. 6).each do |i|
          dt = (date + i.day).strftime('%Y/%m/%d')
          mapping["#{dt} POS Sales"] = mapping_base["POS Sales"].clone
          mapping["#{dt} POS Sales"]['field'] = mapping["#{dt} POS Sales"]['field'] + "_#{i}"
          mapping["#{dt} POS Qty"] = mapping_base["POS Qty"].clone
          mapping["#{dt} POS Qty"]['field'] = mapping["#{dt} POS Qty"]['field'] + "_#{i}"
        end
        sales = translate(data, mapping)
        sales.each do |sale|
          next if sale['Product_ID'] == nil or sale['Product_ID'] == 0
          (0 .. 6).each do |i|
            dt = date + i.day
            quantity = sale["Quantity_#{i}"]
            amount = sale["Amount_#{i}"]

            sql = "delete from Pris.dbo.wm#{store}_POS_Sales where Date = '#{dt}' and Product_ID = #{sale['Product_ID']}"
            rc = ActiveRecord::Base.connection.execute(sql)

            sql = "insert into Pris.dbo.wm#{store}_POS_Sales(Date, Product_ID, Quantity, Amount) values('#{dt}', #{sale['Product_ID']}, #{quantity}, #{amount})"
            #puts sql
            rc = ActiveRecord::Base.connection.execute(sql)
          end
        end
        return "sales records: #{sales.length}"
      end
    elsif self.job_type == 'tsql_sp' then
      sp_name, *sp_args = self.input.split(' ')
      args = {}
      sp_args.each do |arg|
        k, v = arg.split('=')
        args[k] = v
      end
      args['rc'] = 0
      #execute_procedure takes the second args as a hash, name to value
      #what execute_procedure will return?
      #it will return a array of array of hash, each select statement in sp will return as a array of hash, and the concat into a arra
      #if there is only 1 select, it will return a array of hash
      #for example
=begin
      alter PROCEDURE [dbo].[test]
      AS
      BEGIN
      declare @ct integer;
      	SET NOCOUNT ON;


      	select top 3 * from departments;
      	select top 3 * from items;
      	select rc = 'aaa', x=1, y = 2 ;
      	select '1111' as output, '2222' as abc;
      END
=end
      #will return an array of 4, each of them is a array of hash
      #the last 2 select are same, in different syntax
      rc = ActiveRecord::Base.connection.execute_procedure(sp_name, args)

      #if rc[-1]==Array then multiple select in sp else #only 1 select in sp
      result = rc[-1].class==Array ? rc[-1][0]['output'] : rc[-1]['output']
      return result
    end
  end

  def self.delete_wm_items
    job = Job.new
    job.save
    job.name = 'Delete all items'
    job.input = 'dbo.DeleteWmItemsAndItems'
    job.job_type = 'tsql_sp'
    job.save
    job.enqueue
    return job
  end

  def self.push_items(stores)
    job = Job.new
    job.save
    job.name = 'Upload items'
    job.input = 'dbo.UploadItems'
    job.job_type = 'tsql_sp'
    job.save
    job.enqueue

    jobs = [job]
    stores.each do |store|
      job = Job.new
      job.save
      job.name = "Push items #{store}"
      job.input = "dbo.PushItems store=#{store}"
      job.job_type = 'tsql_sp'
      job.save
      job.enqueue
      jobs << job
    end
    return jobs
  end

  def self.pull_alp_items(stores)
    jobs = []
    stores.each do |store|
      job = Job.new
      job.save
      job.name = "Pull #{store} items"
      job.input = "dbo.pull_alp_items store=#{store}"
      job.job_type = 'tsql_sp'
      job.save
      job.enqueue
      jobs << job
    end
    return jobs
  end


  def self.download_stores_products
    job = Job.new
    job.save
    job.name = 'Update Products_Stores'
    job.input = 'dbo.CreateAndDownloadProductsStores'
    job.job_type = 'tsql_sp'
    job.save
    job.enqueue
    return job
  end

  def enqueue
    self.state = 'waiting'
    self.enqueued_at = Time.now
    self.save
    SneakerJob.perform_later(self.id)
  end

  private
  def destroy_files
    File.delete(self.input) if self.input!=nil and File.exist?(self.input)
    File.delete(self.output) if self.output!=nil and File.exist?(self.output)
  end

  def excelToAoA(excel)
    require 'open3'
    stdin, stdout, stderr, wait_thr = Open3.popen3('pyoo/excel2json.py', '--option=1', excel)
    result = stdout.gets(nil)
    stdout.close
    stderr.gets(nil)
    stderr.close
    exit_code = wait_thr.value
    data = JSON.parse(result)
    return data
  end

  def create_or_update_items(items)
    iUpdate = 0
    iInsert = 0
    items.each do |item|
      it = WmItem.find_by(:Item_Nbr => item['Item_Nbr'])
      if (it == nil) then
        it = WmItem.create(item)
        iInsert = iInsert + 1
      else
        it.update(item)
        iUpdate = iUpdate + 1
      end
      it.save
    end
    return iInsert, iUpdate
  end

  def translate(data, mapping)
    header = mapping.keys
    table = data['sheet']
    iHeader = 0
    rowHeader = nil
    (0 .. table.length).each do |i|
      row = table[i]
      match = row & header
      if match.length == header.length then
        iHeader = i
        rowHeader = row
        break
      end
    end
    items = []
    if rowHeader != nil then
      logger.info "excel rows:#{table.length}"
      (iHeader+1 .. table.length-1).each do |i|
        row = table[i]
        item = {}
        (0 .. row.length-1).each do |c|
          cell = row[c]
          if mapping[rowHeader[c]] != nil then
            cell = cell.to_i if mapping[rowHeader[c]]['datatype'] == 'integer'
            cell = cell.to_f if mapping[rowHeader[c]]['datatype'] == 'decimal'
            item[mapping[rowHeader[c]]['field']] = cell
          else
            logger.info "skip #{rowHeader[c]}"
          end
        end
        items << item
      end
    end
    return items
  end
end
