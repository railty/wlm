filename = 'test/fixtures/weekly sales/Store 1080 Sales Dec 12 - 18 2016 Dept 81 83 93 98.xlsx'
job = Job.uploadExcel(File.open(filename), 'Store 1080 Sales Dec 12 - 18 2016 Dept 81 83 93 98.xlsx')
#pyoo/excel2json.py --option=1 data/input/27.xlsx
job.perform
