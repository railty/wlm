#!/usr/bin/python3
import sys
import os.path
import time
import pdb
import json
import pyoo

def connect():
    while True:
        try:
            office = pyoo.Desktop('localhost', 2002)
            break
        except:
            print("Waiting ...")
            time.sleep (250.0 / 1000.0)
    return office

if len(sys.argv) == 2:
    json_setting = sys.argv[1]
    setting = json.loads(open(json_setting).read())
    print(setting)

    if os.path.isfile(setting['excel']):
        office = connect()
        doc = office.open_spreadsheet(setting['excel'])
        sheet = doc.sheets[setting['sheet']]

        headers = []
        for iCol in range(setting['colStart'], setting['colEnd']):
            headers.append(sheet[setting['rowHeader'], iCol].value)

        print(headers)

        iRow = setting['rowHeader'] + 1
        items = []

        while True:
            if eval(setting['rowEnd']):
                break

            item = []
            for iCol in range(setting['colStart'], setting['colEnd']):
                item.append(sheet[iRow, iCol].value)

            items.append(item)
            if iRow % 100 == 0:
                print("reading {0} rows".format(iRow))
            iRow = iRow + 1
        doc.close

        with open(setting['json'], 'w') as outfile:
            json.dump({'headers':headers, 'items':items}, outfile, sort_keys=True, indent=4)
