#!/usr/bin/python
import fnmatch, os, requests, textwrap
from datetime import date, datetime

# date stuff
# formatting for strftime to allow suffix for day of month
def suffix(d):
    return 'th' if 11<=d<=13 else {1:'st',2:'nd',3:'rd'}.get(d%10, 'th')

def custom_strftime(format, t):
    return t.strftime(format).replace('{S}', str(t.day) + suffix(t.day))

def genQuote():
    quote = requests.get("http://api.quotable.io/random").json()
    content = quote["content"]
    content = textwrap.indent(textwrap.fill(content, width=80), "  ")[2:] # autoinsert 80 char linebreak
    author = quote["author"]
    return ' "' + content + '"\n  -- ' + author 

# days since birth
b_date = date(2002, 10, 6)
t_date = date.today()
dayno = t_date - b_date
now = datetime.now()
# display formatting
timestart = now.strftime("%-I:%M %p")
date = custom_strftime("%B {S}, %Y, %A", now)
# yearmath
dayOfYear = now.timetuple().tm_yday
yearPerc = round(dayOfYear / 365 * 100)
date += " -- Day " + str(dayOfYear) + "/365 [" + f"{yearPerc:02}" + "%] • " + str(365 - dayOfYear) + " left"
# count number of files with prefix 20*.md
entrycount = len(fnmatch.filter(os.listdir('/home/carson/files/text/wiki'), '20*.md'))
template = "# An Untitled Day\n* " + date + """
""" + genQuote() + """

-------------------------------------------------------------------------------
## ENTRY """ + str(entrycount) + """ -- START LOG -- INIT """ + timestart + """

## MIDNIGHT -- END OF LOG -- DAY NO """ + str(dayno.days) + """
-------------------------------------------------------------------------------"""
print(template)
