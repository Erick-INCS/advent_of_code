#!/usr/bin/env python3
""" Day 12 """
import re

with open('./inputs/inp_day12.txt') as file:
    data = re.findall(r'(\w)(\d+)', file.read())

data = [(r[0], int(r[1])) for r in data]

class Ship():
    __init__(self, ):

def apply(action, value):
    

print(data)