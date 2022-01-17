#!/usr/bin/python
import sys
from datetime import date, datetime
day = datetime.today().strftime("%a, %b %d %Y")
time = datetime.now().strftime("%H:%M:%S %p")

template = "# Title\n" + day + """
-------------------------------------------------------------------------------
# Entries
## """ + time + """ (created)

-------------------------------------------------------------------------------"""
print(template)
