class Item < ActiveRecord::Base
  has_many :photos, :dependent => :delete_all
  accepts_nested_attributes_for :photos

  belongs_to :products_store, :foreign_key => "vendor_stk_nbr"
  has_one :wm_item, :foreign_key => "Item_Nbr"

  validates :proposed_price, :numericality => true, :allow_nil => true
  validates :proposed_price_ceiling, :numericality => true, :allow_nil => true
  validate :price_less_than_ceiling

  def price_less_than_ceiling
    if self.proposed_price!=nil and self.proposed_price >= self.price_ceiling then
      errors.add(:customer_price, "price can't be more than price ceiling, moved to proposed price ceiling")
      self.proposed_price_ceiling = self.proposed_price
    end
  end

  def print
    Item.execute_procedure "Print_Product_Label", self.upc
  end

  def self.complete_price_changing
    self.where("proposed_price is not null").each do |item|
      item.unit_retail = item.proposed_price
      item.proposed_price = nil
      item.save
      item.print
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

  def self.countries
    tops = ['Canada', 'United States', 'China', 'Mexico', 'Costa Rica', 'Peru', 'Guatemala', 'Taiwan', 'Korea, South', 'Jamaica']
    countries = []
    sql = "SELECT COUNTRY_CODE, COUNTRY_NAME, OFFICIAL_NAME FROM CountryCode Order by COUNTRY_NAME"
    results = ActiveRecord::Base.connection.select_all(sql)
    results.each do |res|
      name = res['COUNTRY_NAME'].strip!
      if tops.include?(name) then
        countries.unshift([res['COUNTRY_CODE'], name, res['OFFICIAL_NAME']])
      else
        countries << [res['COUNTRY_CODE'], name, res['OFFICIAL_NAME']]
      end

    end
    return countries
  end

end
