import subprocess
import signal
import time
import pdb
import pyoo
import json
import sys

def loadData(filename):
    with open(filename) as json_file:
        items = json.load(json_file)
    item = items[list(items.keys())[0]]
    headers = list(item.keys())
    headers = ['WM', 'Current_Price', 'Store', 'Prod_Name', 'Prod_Alias', 'RegPrice', 'OnSalePrice']
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

weekExcel = sys.argv[1]
headers, items = loadData('../data/output/wms.json')
#print(items)

cmd = 'soffice --accept="socket,host=localhost,port=2002;urp;" --norestore --nologo --nodefault' # --headless
soffice = subprocess.Popen(cmd, shell=True)
#print(soffice.pid)

while True:
    try:
        desktop = pyoo.Desktop('localhost', 2002)
        break
    except:
        print("Waiting ...")
        time.sleep (250.0 / 1000.0)

#print(desktop)
doc = desktop.open_spreadsheet(weekExcel)
for sheet, worksheet in {'Al Premium Specific Items': 'ALP Worksheet', 'Shared Items - Require Review': 'Shared Worksheet'}.items():
    print(sheet + '-->' + worksheet)
    doc.sheets.copy(sheet, worksheet, len(doc.sheets))

    sheet = doc.sheets[worksheet]

    rowHeader = 3
    colItemNum = 11
    colExtra = 17

    i = 0
    for header in headers:
        sheet[rowHeader, colExtra + i].value = header
        i = i + 1

    iRow = rowHeader + 2    #normally this is +1, this spreadsheet has an extra blank row
    while True:
        itemNum = sheet[iRow, colItemNum].value
        if not isinstance(itemNum, float):
            break
        itemNum = str(int(itemNum))
        print(itemNum)

        if items.keys().__contains__(itemNum):
            item = items[itemNum]
            i = 0
            for header in headers:
                sheet[iRow, colExtra + i].value = item[header]
                i = i + 1

            color = getColor(sheet[iRow])
            i = 0
            for header in headers:
                sheet[iRow, colExtra + i].background_color = color
                i = i + 1

        iRow = iRow + 1

#pdb.set_trace()
doc.save('worksheet.xlsx', pyoo.FILTER_EXCEL_2007)
doc.close()
subprocess.call("kill `ps|grep soffice.bin| awk '{print $1}'`", shell=True)
