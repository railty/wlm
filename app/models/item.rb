class Item < ActiveRecord::Base
  belongs_to :products_store, :foreign_key => "vendor_stk_nbr"

  def print
    Item.execute_procedure "Print_Product_Label", self.upc
  end

  def self.complete_price_changing
    self.where("proposed_price is not null").each do |item|
      item.unit_retail = item.proposed_price
      item.proposed_price = nil
      item.save
    end
  end

  def self.print_price_changing
    conn = Item.connection_config
    connstr = "#{conn[:host]}:#{conn[:port]}:#{conn[:database]}:#{conn[:username]}:#{conn[:password]}"
    output_file = '/tmp/price_changing_worksheet'
    require 'open3'
    cmd = "pyoo/priceChanging.py data/templates/price_changing_template.xlsx #{output_file}.xlsx #{connstr}"
    logger.info cmd
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      logger.info stdout.read
      logger.error stderr.read
    end

    cmd = "soffice --headless --invisible --convert-to pdf #{output_file}.xlsx --outdir /tmp"
    logger.info cmd
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      logger.info stdout.read
      logger.error stderr.read
    end

    return "#{output_file}.pdf"
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

end
