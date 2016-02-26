# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.new({:email => "zxning@gmail.com", :role => "admin", :password => "123456", :password_confirmation => "123456" }).save!
User.new({:email => "smile.shi@alpremium.ca", :role => "admin", :password => "123456", :password_confirmation => "123456" }).save!
User.new({:email => "jacky.yu@alpremium.ca", :role => "admin", :password => "123456", :password_confirmation => "123456" }).save!

conn = ActiveRecord::Base.connection
sql = File.read('db/country_code.sql')
statements = sql.split(/;$/)
ActiveRecord::Base.transaction do
  statements.each do |statement|
    puts statement
    conn.execute(statement)
  end
end
