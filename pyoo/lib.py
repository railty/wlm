import logging
import os.path
import subprocess
import time
import pyoo
import pytds
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
    def __init__(self, logger=None):
        if logger is None:
            logger = getLogger("excel", False)
        self.logger = logger

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

    def dump(self, fileName, option):
        if os.path.isfile(fileName):
            self.logger.info("option = {}, excel = {}".format(option, fileName))
            office = self.startOffice()
            data = {}
            try:
                doc = office.open_spreadsheet(fileName)
                sheetNames = []
                for sheet in doc.sheets:
                    sheetNames.append(sheet.name)
                data["sheetNames"] = sheetNames

                if (option == 1):
                    sheet = doc.sheets[0]
                    maxRow, maxColumn = sheet.getRange()
                    self.logger.info("sheet '{}' : maxRow = {}, maxColumn = {}".format(sheet.name, maxRow, maxColumn))
                    data["sheet"] = sheet.dump(maxRow, maxColumn)

                elif (option == 2):
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
    for r in range(maxRow + 1):
        row = []
        for c in range(maxColumn + 1):
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

def rgb(r, g, b):
    return 256*(256*r+g)+b

class Db:
    def __init__(self, connstr=None):
        if connstr is None:
            connstr = '192.168.86.1:1433:pris:po:prispo'
        self.connstr = connstr
        [server, port, dbname, username, password] = connstr.split(':')
        self.conn = pytds.connect(server=server, database=dbname, user=username, password=password, port=port)

    def getProductInfo(self, id):
        with self.conn.cursor() as cur:
            cur.execute("select top 1 Item_Nbr, Store, Prod_Name, Prod_Alias, RegPrice, OnSalePrice from wm_items join products_stores on wm_items.Vendor_Stk_Nbr = products_stores.prod_num where wm_items.Item_Nbr='{}'".format(id))
            res = cur.fetchone()
            return res

    def getPriceChangingList(self):
        with self.conn.cursor() as cur:
            cur.execute("select id, upc, signing_desc, unit_retail, proposed_price from items where proposed_price is not null")
            res = cur.fetchall()
            return res
