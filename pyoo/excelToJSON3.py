#!/usr/bin/python3
import sys
import os.path
import time
import pdb
import json
import pyoo

import lib

logger = lib.getLogger("excel to json")
if len(sys.argv) == 2:
    excel = sys.argv[1]
    logger.info(excel)

    if os.path.isfile(excel):
        office = lib.startOffice()
        doc = office.open_spreadsheet(excel)

        sheet = doc.sheets[0]

        headers = []
        for iCol in range(setting['colStart'], setting['colEnd']):
            headers.append(sheet[setting['rowHeader'], iCol].value)

        logger.info(headers)

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
                logger.info("reading {0} rows".format(iRow))
            iRow = iRow + 1
        doc.close

        with open(setting['json'], 'w') as outfile:
            json.dump({'headers':headers, 'items':items}, outfile, sort_keys=True, indent=4)

        lib.closeOffice()
    else:
        logger.info(excel + " not exist")
