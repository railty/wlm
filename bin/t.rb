conn = ActiveRecord::Base.connection
sp1 = 'WmItems2Items'
texts = conn.execute_procedure("sp_helptext '#{sp1}'")

sql = ''
texts.each do |text|
  sql = sql + text['Text']
end

sql.gsub!(/create PROCEDURE \[dbo\]\.\[#{sp1}\]/mi, "create PROCEDURE [dbo].[#{sp1}_bak]")
puts sql
conn.execute("SET ANSI_NULLS ON")
conn.execute("SET QUOTED_IDENTIFIER ON")
conn.execute(sql)
