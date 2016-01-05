#!/usr/bin/python3
import sys
import time
import pdb
import pyoo
import argparse
import lib


parser = argparse.ArgumentParser(description='dump excel data into json.')
parser.add_argument('--option', default=0, type=int, help='options: 0 for sheet name list, 1 for first sheet, 2 for all sheets')
parser.add_argument('excel_filename', help='input excel filename')

args = parser.parse_args()

option = args.option
excelFileName = args.excel_filename

excel = lib.Excel(excelFileName, option)
excel.dump()
