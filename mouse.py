import os
import wx
from ConfigParser import SafeConfigParser
parser = SafeConfigParser()

# Create config.ini if it doesn't exist
if not os.path.isfile('.\config.ini'):
    file = open('.\config.ini', 'w')
    file.write('')
    file.close()

# Read config.ini
parser.read('config.ini')

# Create directories if they don't exist
for dir in ['menus', 'keys']:
    try:
        os.makedirs(dir)
    except OSError:
        pass

# Tray menu stuff
TRAY_TOOLTIP = 'Mouse Fortress Version ' + parser.get('info', 'version') + ' for DF Version ' + parser.get('info', 'dfversion')
TRAY_ICON = 'mouse.ico'