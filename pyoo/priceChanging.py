#!/usr/bin/python3
import sys
import time
import datetime
import pdb
import pyoo
import argparse
import lib

parser = argparse.ArgumentParser(description='price changing report.')
parser.add_argument('input_excel_filename', help='input excel template filename')
parser.add_argument('output_pdf_filename', help='output pdf filename')
parser.add_argument('connstr', help='db connection string')
args = parser.parse_args()
fileName = args.input_excel_filename
connstr = args.connstr

db = lib.Db(connstr)
items = db.getPriceChangingList()

logger = lib.getLogger("excel", False)
excel = lib.Excel(logger)
office = excel.startOffice()

try:
    doc = office.open_spreadsheet(fileName)
    sheet = doc.sheets[0]

    iRow = 5
    for item in items:
        for iCol in range(5):
            sheet[iRow, iCol].value = item[iCol]
        iRow = iRow + 1
    #pdb.set_trace()
    doc.save('/tmp/price_changing_worksheet.xlsx', pyoo.FILTER_EXCEL_2007)
    doc.close
except Exception as e:
    logger.info("Error: {}".format(e))
finally:
    excel.closeOffice()
