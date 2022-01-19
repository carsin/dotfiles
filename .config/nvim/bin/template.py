#!/usr/bin/python
import sys
from datetime import date, datetime

b_date = date(2002, 10, 6)
t_date = date.today()
dayno = t_date - b_date
timestart = datetime.now().strftime("%-I:%M %p")
date = datetime.now().strftime("%a %m/%d/%Y")
day = t_date.strftime("%a, %b %d %Y")

template = "# PLACEHOLDER" + """

-------------------------------------------------------------------------------
# MIDNIGHT -- END OF LOG -- DAY NO """ + str(dayno.days) + """
##

-*-
# """ + timestart + """ -- INIT LOG -- """ + date.upper() + """
-------------------------------------------------------------------------------"""
print(template)
