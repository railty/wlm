class ReportController < ApplicationController
  def pph
    ActiveRecord::Base.establish_connection(Rails.configuration.database_configuration['alp'])
    #records = ActiveRecord::Base.connection.select_all("select * from PPH_GetReport('2016-04-21')")
    records = ActiveRecord::Base.connection.select_all("select * from cached_report order by department")
    records.each do |r|
      r['Dt'].gsub!('2016-', '').gsub!('-', '/')
      r['LastDt'].gsub!('2016-', '').gsub!('-', '/')
      r['ReceivedDt'].gsub!('2016-', '').gsub!('-', '/')
      r['LastReceivedDt'].gsub!('2016-', '').gsub!('-', '/')
    end
    @records = records.group_by{|r|r['Department']}

  end
end
