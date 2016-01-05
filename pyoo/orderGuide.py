#!/usr/bin/python3
import subprocess
import signal
import time
import pdb
import pyoo
import json
import sys
import os
import lib

def loadData(filename):
    with open(filename) as json_file:
        items = json.load(json_file)
    item = items[list(items.keys())[0]]
    headers = list(item.keys())
    headers = ['WM', 'Store', 'Prod_Name', 'Prod_Alias', 'RegPrice', 'OnSalePrice']
    return (headers, items)

def rgb(r, g, b):
    return 256*(256*r+g)+b

def getColor(row):
    red = rgb(255, 0, 0)
    green = rgb(0, 255, 0)
    try:
        g = float(row[6].value)
    except:
        g = 0

    try:
        w = float(row[22].value)
    except:
        w = 0
    return red if g < w else green

logger = lib.getLogger("order guide")
headers, items = loadData('data/output/wms.json')
logger.debug("total items: %d".format(len(items.keys())))
if len(sys.argv) == 2:
    json_setting = sys.argv[1]
    setting = json.loads(open(json_setting).read())
    logger.info(setting)

    if os.path.isfile(setting['excel']):
        office = lib.startOffice()
        doc = office.open_spreadsheet(setting['excel'])

        for sheet, worksheet in {'1080 Order Guide': 'Worksheet'}.items():
            print(sheet + '-->' + worksheet)
            doc.sheets.copy(sheet, worksheet, len(doc.sheets))

            sheet = doc.sheets[worksheet]
            sheet.hideColumns(['A', 'B', 'C', 'D', 'E', 'F', 'K', 'L', 'M'])

            rowHeader = 0
            colItemNum = 6
            colFill = 10

            iRow = rowHeader + 1    #normally this is +1, this spreadsheet has an extra blank row
            while True:
                itemNum = sheet[iRow, colItemNum].value
                if not isinstance(itemNum, float):
                    break
                itemNum = str(int(itemNum))
                logger.info(itemNum)
                pdb.set_trace()
                if items.keys().__contains__(itemNum):
                    print("1111")

                    item = items[itemNum]
                    sheet[iRow, colFill].value = item['Prod_Alias']


                iRow = iRow + 1

#N
#Every day as SSTK
#S,M,T,W,TH,F,S
#_,_,_,_,_,F,_



doc.save('data/output/order_guide_worksheet.xlsx', pyoo.FILTER_EXCEL_2007)
doc.close()
lib.closeOffice()
