#!/usr/bin/python
# -*- coding: utf-8 -*-
""" matrix """

from __future__ import print_function

import itertools

CHARS = ['K', 'B', 'D']
MASK = ''.join(reversed(CHARS))
for bits in itertools.product([0, 1], repeat=len(CHARS)):
    SBIT = "".join(str(bit) for bit in bits)
    NST = ""
    for i, _ in enumerate(SBIT):
        if SBIT[i] == "1":
            NST += MASK[i]
        else:
            NST += "-"
    print(NST)
