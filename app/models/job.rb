class Job < ActiveRecord::Base
  before_destroy :destroy_files

  def run
    self.state = 'processing'
    self.start = Time.now
    self.save
    if self.job_type == 'priceGuide' then

      conn = Item.connection_config
      connstr = "#{conn[:host]}:#{conn[:port]}:#{conn[:database]}:#{conn[:username]}:#{conn[:password]}"
      require 'open3'
      cmd = "pyoo/priceGuide.py #{self.input} #{self.output} #{connstr}"
      logger.info cmd
      Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
        self.stdout = stdout.read
        self.stderr = stderr.read
      end
    end
    self.finish = Time.now
    self.state = 'completed'
    self.save
  end

  def self.uploadExcel(originalExcelFile, originalExcelFileName)
    if originalExcelFileName =~ /^Daily Report /i or originalExcelFileName =~ /^hwadiwa_/i then
      job = Job.new
      job.save
      ext = File.extname(originalExcelFileName)
      excelFile = "data/input/#{job.id}#{ext}"
      FileUtils::copy(originalExcelFile, excelFile)
      job.job_type = originalExcelFileName =~ /^Daily Report /i ? 'import_alp_products' : 'import_wm_products'
      job.input = excelFile
      job.save
      job.enqueue
      return job
    elsif originalExcelFileName =~ /Pricing Guide/i then
    else
      return false
    end
  end

  def self.priceGuide(excelTempfile, excelFileName)
    tm = Time.now.strftime("%Y-%m-%d-%H-%M")
    ext = File.extname(excelFileName)

    job = self.new
    job.input = "data/input/#{tm}#{ext}"
    job.output = "data/output/#{tm}.xlsx"
    FileUtils::copy(excelTempfile, job.input)
    job.name = "Price Guide #{tm}"
    job.job_type = 'priceGuide'
    job.state = 'waiting'
    job.save
    job.run
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

      create_or_update_items(items) if items != nil
      ActiveRecord::Base.connection.execute_procedure 'dbo.WmItems2Items'
    end
  end

  def self.delete_wm_items
    WmItem.destroy_all
  end

  def self.download_stores_products
    ct = ActiveRecord::Base.connection.execute_procedure 'dbo.Create_And_Download_Products_Stores'
    ct = ct[0][0]['']
    puts ct
    return true
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
    items.each do |item|
      it = WmItem.find_by(:Item_Nbr => item['Item_Nbr'])
      if (it == nil) then
        it = WmItem.create(item)
      else
        it.update(item)
      end
      it.save
    end
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
