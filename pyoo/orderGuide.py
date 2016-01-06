#!/usr/bin/python3
import sys
import time
import datetime
import pdb
import pyoo
import argparse
import lib

parser = argparse.ArgumentParser(description='order guide process.')
parser.add_argument('excel_filename', help='input excel filename')
args = parser.parse_args()
fileName = args.excel_filename

logger = lib.getLogger("excel", False)
excel = lib.Excel(logger)
office = excel.startOffice()
data = {}
try:
    doc = office.open_spreadsheet(fileName)

    for sheet, worksheet in {'1080 Order Guide': 'Worksheet'}.items():
        print(sheet + '-->' + worksheet)
        doc.sheets.copy(sheet, worksheet, len(doc.sheets))

        sheet = doc.sheets[worksheet]
        sheet.hideColumns(['A', 'B', 'C', 'D', 'E', 'F', 'K', 'L', 'M'])

        rowHeader = 0
        colItemNum = 6
        colChinese = 10
        colDates = 13
        colFill = 17

        for i in range(7):
            sheet[0, colFill+i].value = datetime.date(2016, 1, 3 + i).strftime("%a")

        iRow = rowHeader + 1
        while True:
            itemNum = sheet[iRow, colItemNum].value
            if not isinstance(itemNum, float):
                break
            itemNum = int(itemNum)
            logger.info(itemNum)

            #info = getProductInfo(itemNum)
            #if info is not None:
            #    print(info)
            #    #sheet[iRow, colFill].value = item['Prod_Alias']

            dates = sheet[iRow, colDates].value
            if dates == 'Order as needed as SSTK':
                dates = 'S,M,T,W,TH,F,S'

            dates = dates.split(',')
            for i in range(7):
                if dates[i] == '_':
                    sheet[iRow, colFill+i].background_color = lib.rgb(0, 0, 0)

            iRow = iRow + 1

    #pdb.set_trace()
    doc.save('data/output/order_guide_worksheet.xlsx', pyoo.FILTER_EXCEL_2007)
    doc.close
except Exception as e:
    logger.info("Error: {}".format(e))
finally:
    excel.closeOffice()
