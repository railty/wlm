require 'pathname'
require 'io/console'

def dayly
Dir['test/fixtures/daily sales/*.xlsx'].each do |filename|
  puts filename
  job = Job.uploadExcel(File.open(filename), Pathname.new(filename).basename.to_s)
  ##pyoo/excel2json.py --option=1 data/input/27.xlsx
  job.perform
  #puts "11111"
  #STDIN.getch
end
end


Dir['test/fixtures/weekly sales/*.xlsx'].each do |filename|
  puts filename
  job = Job.uploadExcel(File.open(filename), Pathname.new(filename).basename.to_s)
  ##pyoo/excel2json.py --option=1 data/input/27.xlsx
  job.perform
  #puts "11111"
  #STDIN.getch
end

