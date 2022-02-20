#!/usr/bin/python

# TODO: REDO in shell with zk
import fnmatch, os, requests, textwrap, calendar
from datetime import date, datetime

# get inspiration quote from api
def genQuote():
    quote = requests.get("http://api.quotable.io/random").json()
    content = quote["content"]
    content = textwrap.indent(textwrap.fill(content, width=80), "  ")[2:] # autoinsert 80 char linebreak
    author = quote["author"]
    return ' "' + content + '"\n  -- ' + author 

# date stuff
# formatting for strftime to allow suffix for day of month
def suffix(d):
    return 'th' if 11 <= d <= 13 else { 1:'st',2:'nd',3:'rd' }.get(d % 10, 'th')

def custom_strftime(format, t):
    return t.strftime(format).replace('{S}', str(t.day) + suffix(t.day))

# days since birth
b_date = date(2002, 10, 6)
c_date = date(2022, 4, 13)
t_date = date.today()
dayno = t_date - b_date
temptf = c_date - t_date
now = datetime.now()
# display formatting
timestart = now.strftime("%-I:%M %p")
date = custom_strftime("%A, %B {S}, %Y", now)
daysInYear = 365 + calendar.isleap(now.year)
# yearmath
dayOfYear = now.timetuple().tm_yday
yearPerc = round(dayOfYear / daysInYear * 100, 2)
date += " • Day " + str(dayOfYear) + "/" + str(daysInYear) + " (" + f"{yearPerc:04}" + "%) • " + str(daysInYear - dayOfYear) + " left [" + str(temptf.days) + "TCF]"
# count number of files with prefix 20*.md
# dateshort = now.strftime("%a %m/%d/%Y").upper()
entrycount = len(fnmatch.filter(os.listdir('/home/carson/files/docs/wiki/log/'), '20*.md'))

template = "# " + now.strftime("%-m/%d/%Y") + "\n" + genQuote() + """
 
""" + date + """
--------------------------------------------------------------------------------
# ENTRY """ + str(entrycount) + """ -- INIT LOG -- CREATED """ + timestart + """

# MIDNIGHT -- END OF LOG -- DAY """ + str(dayno.days) + """
## NIGHTLY REFLECTION
### Accomplishments
### Thankful for
### Tomorrow's intentions
--------------------------------------------------------------------------------
:daily:"""
print(template)
