#!/usr/bin/python3
import sys
import time
import datetime
import pdb
import pyoo
import argparse
import lib

def getColor(row):
    red = lib.rgb(255, 0, 0)
    green = lib.rgb(0, 255, 0)
    try:
        g = float(row[6].value)
    except:
        g = 0

    try:
        w = float(row[22].value)
    except:
        w = 0
    return red if g < w else green

parser = argparse.ArgumentParser(description='price guide process.')
parser.add_argument('input_excel_filename', help='input excel filename')
parser.add_argument('output_excel_filename', help='output excel filename')
parser.add_argument('connstr', help='db connection string')
args = parser.parse_args()
fileName = args.input_excel_filename
connstr = args.connstr

db = lib.Db(connstr)

headers = ['WM', 'Store', 'Prod_Name', 'Prod_Alias', 'RegPrice', 'OnSalePrice']
logger = lib.getLogger("excel", False)
excel = lib.Excel(logger)
office = excel.startOffice()

try:
    doc = office.open_spreadsheet(fileName)

    for sheet, worksheet in {'Al Premium Specific Items': 'ALP Worksheet', 'Shared Items - Require Review': 'Shared Worksheet'}.items():
        print(sheet + '-->' + worksheet)
        doc.sheets.copy(sheet, worksheet, len(doc.sheets))

        sheet = doc.sheets[worksheet]

        rowHeader = 3
        colItemNum = 11
        colExtra = 18

        i = 0
        for header in headers:
            sheet[rowHeader, colExtra + i].value = header
            i = i + 1

        iRow = rowHeader + 2    #normally this is +1, this spreadsheet has an extra blank row
        while True:
            itemNum = sheet[iRow, colItemNum].value
            if not isinstance(itemNum, float):
                break
            itemNum = int(itemNum)
            logger.info(itemNum)

            item = db.getProductInfo(itemNum)
            if item is not None:
                for i in range(len(headers)):
                    sheet[iRow, colExtra + i].value = item[i]

                color = getColor(sheet[iRow])
                for i in range(len(headers)):
                    sheet[iRow, colExtra + i].background_color = color

            iRow = iRow + 1

    #pdb.set_trace()
    doc.save(args.output_excel_filename, pyoo.FILTER_EXCEL_2007)
    doc.close
except Exception as e:
    logger.info("Error: {}".format(e))
finally:
    excel.closeOffice()
