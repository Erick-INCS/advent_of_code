#!/usr/bin/env python3
""" Docstring """

import pandas as pd
import numpy as np

with open('day_2_input.txt') as inp:
    data = inp.readlines()

data = list(map(lambda d: d.strip(), data))

data = pd.DataFrame(data)


def verify(s):
    statement = s.split(':')
    passwd = statement[1].strip()
    statement = statement[0]

    letter = statement[-1]
    #times = np.sum(list(map(lambda l: l==letter, passwd)))

    limits = statement[:-2].split('-')
    limits = list(map(lambda l: passwd[int(l)-1], limits))

    print(limits, statement, passwd, limits[0] != limits[1] and (limits[0]==letter or limits[1] == letter))

    return limits[0] != limits[1] and (limits[0]==letter or limits[1] == letter)

print(data[0].apply(verify).sum())
