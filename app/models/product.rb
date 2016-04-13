class Product < ActiveRecord::Base
  self.primary_key = 'Prod_Num'
  establish_connection(self.configurations['ofc'])
  def self.departments

    return self.group('department').order('department').count('department').map do |dept|
      dept[0] = 'null' if dept[0]==''
      dept
    end
  end
end
