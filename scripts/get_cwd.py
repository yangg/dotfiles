#!/usr/bin/env python
# -*- coding: utf-8 -*-

# http://jagt.github.io/python-single-line-convert/

import os,re
home, names = os.getenv("HOME"), os.getcwd().split(os.sep)
if not names[0]: names.pop(0)
path = ""
for i in range(len(names)):
    path += os.sep + names[i]
    if os.path.samefile(path, home):
        names = ["~"] + names[i+1:]
        break
if names[0] != "~": names[0] = "/" + names[0]
max_depth = 5
if len(names) > max_depth:
    names = names[:2] + ["..."] + names[3 - max_depth:]
print os.sep.join(names)
