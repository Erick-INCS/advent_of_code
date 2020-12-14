#!/usr/bin/env python3
# -*- coding utf-8 -*-
import numpy as np
import re

with open("./inputs/inp_day14.txt") as file:
    inp = file.read().split('\n')


mem_re = re.compile(r'mem\[(\w+)\] = (\d+)')
mask_re = re.compile(r'mask = (\w*)')

# inp = [mem_re.findall(s)[0] if "mem" in s else mask_re.findall(s)[0]
#        for s in inp[:-1]]

def applyMask(mask, num):
    mask = list(mask)[::-1]
    num = num[::-1]
    
    for i, c in enumerate(mask):
        if c == 'X':
            if i < len(num):
                mask[i] = num[i]
            else:
                mask[i] = '0'
    return ''.join(mask)[::-1]

## Functions part 2
def develop(mask):
    cp = mask.copy()
    if 'X' in mask:
        for i in range(len(cp)):
            if cp[i] == "X":
                cp[i] = '0'
                zero = develop(cp)
                cp[i] = '1'
                one = develop(cp)
                
                return [*zero, *one]
    else:             
        return [''.join(cp)]

def applyMask2(mask, num):
    mask = list(mask)[::-1]
    num = num[::-1]
    
    for i, c in enumerate(mask):
        if c == '0':
            if i < len(num):
                mask[i] = num[i]
            else:
                mask[i] = '0'

    return develop(mask[::-1])

# Part 1
# newInp = []
# for i in inp[:-1]:
#     if 'mask' in i:
#         newInp.append((mask_re.findall(i)[0], []))
#     else:
#         r = mem_re.findall(i)[0]
#         newInp[-1][1].append( (int(r[0]), bin(int(r[1]))[2:]) )
    
# inp = newInp
# del newInp

# mem = {}

# for sample in inp:
#     mask = sample[0]
#     for action in sample[1]:
#         mem[action[0]] = applyMask(mask, action[1])
        
# total = 0
# for i in mem:
#     total += mem[i]
# print(sum(map(lambda k: int(mem[k], 2), mem)))

# Part 2
newInp = []
for i in inp[:-1]:
    if 'mask' in i:
        newInp.append((mask_re.findall(i)[0], []))
    else:
        r = mem_re.findall(i)[0]
        newInp[-1][1].append( (bin(int(r[0]))[2:], int(r[1])))
    
inp = newInp
del newInp

mem = {}

for sample in inp:
    mask = sample[0]
    for action in sample[1]:
        dirs = list(map(lambda x: int(x, 2), applyMask2(mask, action[0])))
        for dr in dirs:
            mem[dr] = action[1]
        
total = 0
for i in mem:
    if mem[i] > 0:
        total += mem[i]
    
print(total)