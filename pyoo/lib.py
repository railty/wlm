import logging
import os.path
import subprocess
import time
import pyoo
import json
import pdb

def getLogger(app, withStdout=True):
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    logger = logging.getLogger(app)
    logger.setLevel(logging.DEBUG)

    fh = logging.FileHandler('log/pyoo.log')
    fh.setLevel(logging.DEBUG)
    fh.setFormatter(formatter)
    logger.addHandler(fh)

    if withStdout:
        ch = logging.StreamHandler()
        ch.setLevel(logging.DEBUG)
        ch.setFormatter(formatter)
        logger.addHandler(ch)

    return logger

class Excel:
    def __init__(self, fileName, option):
        self.fileName = fileName
        self.option = option
        self.logger = getLogger("excel to json", False)
        self.logger.info("option = {}, excel = {}".format(self.option, self.fileName))

    def startOffice(self, quite=True):

        cmd = 'soffice --accept="socket,host=localhost,port=2002;urp;" --norestore --nologo --nodefault'
        if quite:
            cmd = cmd + ' --headless'
        soffice = subprocess.Popen(cmd, shell=True)

        while True:
            try:
                office = pyoo.Desktop('localhost', 2002)
                break
            except:
                self.logger.info("Waiting ...")
                time.sleep (250.0 / 1000.0)
        pyoo.Sheet.hideColumns = hideColumns
        pyoo.Sheet.hideColumn = hideColumn
        pyoo.Sheet.getRange = getRange
        pyoo.Sheet.dump = dumpSheet

        return office

    def closeOffice(self):
        cmd = "kill `ps -A|grep soffice.bin| awk '{print $1}'`"
        #print(cmd)
        subprocess.call(cmd, shell=True)

    def dump(self):
        if os.path.isfile(self.fileName):
            office = self.startOffice()
            data = {}
            try:
                doc = office.open_spreadsheet(self.fileName)
                sheetNames = []
                for sheet in doc.sheets:
                    sheetNames.append(sheet.name)
                data["sheetNames"] = sheetNames

                if (self.option == 1):
                    sheet = doc.sheets[0]
                    maxRow, maxColumn = sheet.getRange()
                    self.logger.info("sheet '{}' : maxRow = {}, maxColumn = {}".format(sheet.name, maxRow, maxColumn))
                    data["sheet"] = sheet.dump(maxRow, maxColumn)

                elif (self.option == 2):
                    data["sheets"] = []
                    for sheet in doc.sheets:
                        maxRow, maxColumn = sheet.getRange()
                        self.logger.info("sheet '{}' : maxRow = {}, maxColumn = {}".format(sheet.name, maxRow, maxColumn))
                        data["sheets"].append(sheet.dump(maxRow, maxColumn))

                doc.close
            except Exception as e:
                self.logger.info("Error: {}".format(e))
            finally:
                self.closeOffice()

            print(json.dumps(data, sort_keys=True, indent=4) )

        else:
            self.logger.info("cannot find {}".format(self.fileName))

def dumpSheet(self, maxRow, maxColumn):
    table = []
    for r in range(maxRow):
        row = []
        for c in range(maxColumn):
            row.append(self[r, c].value)
        table.append(row)
    return table

def getRange(self):
    _target = self._target
    cellRange = _target.getCellRangeByPosition(1, 1, 1, 1)
    cursor = _target.createCursorByRange(cellRange)
    cursor.gotoEndOfUsedArea(False)
    rangeAddress = cursor.RangeAddress
    return rangeAddress.EndRow, rangeAddress.EndColumn

def hideColumn(self, col):
    _target = self._target
    _target.getColumns().getByName(col).IsVisible = False

def hideColumns(self, cols):
    for col in cols:
        self.hideColumn(col)
