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
    elsif self.job_type == 'tsql_sp' then
      result = 0
      rc = ActiveRecord::Base.connection.execute_procedure(self.input, result)
      #rc is a arrah of hash of the return
      result = rc[0]['rc']
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
      job.input = "dbo.PushItems #{store}"
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
    job.input = 'dbo.Create_And_Download_Products_Stores'
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
