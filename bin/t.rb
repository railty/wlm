rc = ActiveRecord::Base.connection.execute_procedure('dbo.test')
result = rc[-1]==Array ? rc[-1][0]['output'] : rc[-1]['output']
puts result
