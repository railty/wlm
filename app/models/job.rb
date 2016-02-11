class Job < ActiveRecord::Base
  before_destroy :destroy_files

  def run
    self.state = 'processing'
    self.start = Time.now
    self.save
    if self.job_type == 'priceGuide' then
      require 'open3'
      cmd = "pyoo/priceGuide.py #{self.input} #{self.output}"
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

  def self.importWmItems(excelTempfile, excelFileName)
    job = Time.now.strftime("%Y-%m-%d-%H-%M-%S")
    ext = File.extname(excelFileName)
    excelFile = "data/input/#{job}#{ext}"
    FileUtils::copy(excelTempfile, excelFile)

    data = excelToAoA(excelFile)
    items = nil
    if excelFileName =~ /^Daily Report /i then
      mapping = JSON.parse(File.read("db/migrate/import_alp_products.json"))
      items = translate(data, mapping)
      items.each do |item|
        item['Source'] = 'ALP'
      end
    elsif excelFileName =~ /^hwadiwa_/i then
      mapping = JSON.parse(File.read("db/migrate/import_wm_products.json"))
      items = translate(data, mapping)

      items.each do |item|
        item['Acct_Dept_Nbr'] = 94
        item['Dept_Desc'] = 'PRODUCE'
        item['Source'] = 'WM'
      end
    end

    create_or_update_items(items) if items != nil
  end

  def self.excelToAoA(excel)
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

  def self.create_or_update_items(items)
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

  def self.translate(data, mapping)
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
      puts table.length
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
            puts "skip #{rowHeader[c]}"
          end
        end
        items << item
      end
    end
    return items
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

  private
  def destroy_files
    File.delete(self.input) if File.exist?(self.input)
    File.delete(self.output) if File.exist?(self.output)
  end

end
