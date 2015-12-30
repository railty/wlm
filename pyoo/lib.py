import logging
import subprocess
import pyoo

def getLogger(app):
    logger = logging.getLogger(app)

    logger.setLevel(logging.DEBUG)
    fh = logging.FileHandler('log/pyoo.log')
    fh.setLevel(logging.DEBUG)
    ch = logging.StreamHandler()
    ch.setLevel(logging.DEBUG)

    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    fh.setFormatter(formatter)
    ch.setFormatter(formatter)
    logger.addHandler(fh)
    logger.addHandler(ch)

    return logger

def startOffice():
    cmd = 'soffice --accept="socket,host=localhost,port=2002;urp;" --norestore --nologo --nodefault --headless'
    soffice = subprocess.Popen(cmd, shell=True)

    while True:
        try:
            office = pyoo.Desktop('localhost', 2002)
            break
        except:
            print("Waiting ...")
            time.sleep (250.0 / 1000.0)
    return office

def closeOffice():
    subprocess.call("kill `ps|grep soffice.bin| awk '{print $1}'`", shell=True)
