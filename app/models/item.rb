class Item < ActiveRecord::Base
  def print
    Item.execute_procedure "Print_Product_Label", self.upc
  end

  def self.complete_price
    self.where("proposed_price is not null").each do |item|
      item.unit_retail = item.proposed_price
      item.proposed_price = nil
      item.save
    end
  end

  def self.countrys
    countries = []
    sql = "SELECT COUNTRY_CODE, COUNTRY_NAME, OFFICIAL_NAME FROM CountryCode"
    results = ActiveRecord::Base.connection.select_all(sql)
    results.each do |res|
      countries << [res['COUNTRY_CODE'], res['COUNTRY_NAME'], res['OFFICIAL_NAME']]
    end
    return countries
  end

  def self.importExcel(excelTempfile, excelFileName)
    job = Time.now.strftime("%Y-%m-%d-%H-%M-%S")
    ext = File.extname(excelFileName)
    excelFile = "data/input/#{job}#{ext}"
    FileUtils::copy(excelTempfile, excelFile)

    data = excelToAoA(excelFile)
    items = nil
    if excelFileName =~ /^Daily Report / then
      mapping = JSON.parse(File.read("db/migrate/import_alp_products.json"))
      items = translate(data, mapping)
      items.each do |item|
        item['owner'] = 'ALP'
      end
    elsif excelFileName =~ /^hwadiwa_/
      mapping = JSON.parse(File.read("db/migrate/import_wm_products.json"))
      items = translate(data, mapping)

      items.each do |item|
        item['department_id'] = 94
        item['owner'] = 'WM'
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
      it = Item.find_by(:id => item['id'])
      if (it == nil) then
        it = Item.create(item)
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

end
