#!/usr/bin/python
# -*- coding: utf-8 -*-
""" combinations """

from __future__ import print_function

import itertools
import re

CHARS = ['K', 'S', 'U', 'T', 'D']
MASK = ''.join(reversed(CHARS))
for i in range(1, len(CHARS)+1):
    for comb in itertools.combinations(CHARS, i):
        REG = "[^%s]" % ''.join(comb)
        print(re.sub(REG, "-", MASK))
