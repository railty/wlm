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

end
