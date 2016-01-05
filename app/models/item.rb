class Item < ActiveRecord::Base
  def print
    Item.execute_procedure "Print_Product_Label", self.vendor_stk_nbr
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

    setting = {'excel' => excelFile, 'job' => job}

    if excelFileName =~ /^Daily Report / then
      importDaily(setting)
    elsif excelFileName =~ /^hwadiwa_/
      import_wm_products(setting)
    end
  end

  def self.importDaily(setting)
    job = setting['job']
    setting['json'] = "data/output/#{job}.json"
    setting['sheet'] = 0

    setting['rowHeader'] = 18
    setting['colStart'] = 0
    setting['colEnd'] = 17  #the new vdpk_cost is not used, to use, change this to 18 and modify db/migration/items.json
    setting['rowStart'] = setting['rowHeader'] + 1
    setting['rowEnd'] = 'not isinstance(sheet[iRow, 0].value, float)'

    File.open("data/jobs/#{job}.json","w") do |f|
      f.write(JSON.pretty_generate(setting))
    end

    cmd = "pyoo/excelToJSON.py data/jobs/#{job}.json"
    Rails.logger.info cmd
    system(cmd)

    items = JSON.parse(File.read(setting['json']))
    puts items['items'].length

    self.loadData(job)
    return job
  end

  def self.import_wm_products(setting)
    excel = setting['excel']

    require 'open3'
    stdin, stdout, stderr, wait_thr = Open3.popen3('pyoo/excel2json.py', '--option=1', excel)
    result = stdout.gets(nil)
    stdout.close
    stderr.gets(nil)
    stderr.close
    exit_code = wait_thr.value

    data = JSON.parse(result)
    debugger 
  end

  def self.loadData(job)
    #Item.destroy_all
    attrs = JSON.parse(File.read("db/migrate/items.json"))
    map = {'Item Nbr' => 'id'}
    attrs.each do |attr|
      map[attr['description']] = attr['name']
    end
    #puts map

    puts "loading data/output/#{job}.json"
    data = JSON.parse(File.read("data/output/#{job}.json"))
    headers = data['headers']
    ct = 0
    items = []
    departments = {}
    data['items'].each do |d|
      #break if ct > 100
      item = {}
      (0 .. d.length-1).each do |i|
        if headers[i] == 'Dept Desc' then
          departments[item['department_id']] = d[i]
          next
        end

        name = map[headers[i]]
        value = d[i]
        value = value.to_i if ['id', 'department_id'].include?(name)
        item[name] = value
      end
      items << item
      puts "loaded #{ct} items" if ct % 100 == 0
      ct = ct + 1
    end
    #puts items
    debugger
    #Item.create(items)
    items.each do |item|
      it = Item.find_by(:id => item['id'])
      if (it == nil) then
        it = Item.create(item)
      else
        it.update(item)
      end
      it.save
    end

    puts "total items: #{Item.all.length}"

    Department.destroy_all
    departments.each do |k, v|
      Department.create({'id' => k, 'name' => v})
    end
  end

  def self.generateJsonForMigration(job)
    data = JSON.parse(File.read("data/output/#{job}.json"))

    attrs = []
    data['headers'].each do |header|
      puts header
      attrs << {'table': 'items', 'name': header.downcase.gsub(/[^0-9a-zA-Z]/, '_'), 'description': header, 'datatype': 'string', 'options': ''}
    end
    File.open("db/migrate/items.json","w") do |f|
      f.write(JSON.pretty_generate(attrs))
    end
    return 1
  end

  def self.jsonToMigration(table)
    template = "db/migrate/#{table}.template"
    if not File.exist?(template) then
      puts "cannot find #{table} migration template, exit."
    else
      fds = []
      attrs = JSON.parse(File.read("db/migrate/#{table}.json"))
      attrs.each do |attr|
        fd = "t.#{attr['datatype']} :#{attr['name']}"
        fd = fd + ", #{attr['options']}" if attr['options'] != ""
        fds << fd + "\n"
      end

      ls = File.readlines(template)
      spaces = nil
      insert_at = nil
      (0 .. ls.length).each do |i|
        if ls[i] =~ /(\s*)\#\{json_attrs\}/ then
          spaces = $1
          insert_at = i
          break
        end
      end
      if spaces != nil then
        fds.map! do |fd|
          spaces + fd
        end
      end
      if insert_at != nil then
        nls = ls[0, insert_at] + fds + ls[insert_at+1, ls.length]

        if Dir["db/migrate/*items.rb"].length == 1 then
          migration = Dir["db/migrate/*items.rb"][0]
          puts "updating #{migration} ... "
          File.open(migration, "w") do |f|
            nls.each do |l|
              f.write(l)
            end
          end
        end
      end
    end
    return 11
  end
end
