# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new({:email => "zxning@gmail.com", :role => "admin", :password => "123456", :password_confirmation => "123456" })
admin.save!
admin = User.new({:email => "sshi@orientalfoods.ca", :role => "admin", :password => "123456", :password_confirmation => "123456" })
admin.save!
admin = User.new({:email => "jacky.yu@alpremium.ca", :role => "admin", :password => "123456", :password_confirmation => "123456" })
admin.save!
