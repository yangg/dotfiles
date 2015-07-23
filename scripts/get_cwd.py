#!/usr/bin/env python
# -*- coding: utf-8 -*-

# http://jagt.github.io/python-single-line-convert/
import os, re
home, names = os.getenv("HOME"), os.getenv('PWD').split('/')
if not names[0]:
    names.pop(0)
path = ""
# add leading slash for windows
home = re.sub('^(?=[^/])', '/', home)
for i,name in enumerate(names):
    path += '/' + name
    # if os.path.samefile(path, home):
    if path == home:
        names = ["~"] + names[i+1:]
        break
if names[0] != "~" and names[0][1] != ':' :
    names[0] = "/" + names[0]
max_depth = 7
if len(names) > max_depth:
    names = names[:3] + ["..."] + names[4 - max_depth:]
print '/'.join(names),

try:
    os.getcwd()
except:
    print '(Invalid CWD)'
