#!/usr/bin/env python3
import numpy as np

with open("./inputs/inp_day12.txt") as file:
    inp = file.read().split('\n')

minTime = int(inp[0])
buses = np.array([n for n in inp[1].split(',') if not n in ['x', '']], dtype=np.int64)
del inp

occurences = (minTime - (minTime%buses))
while max(occurences - minTime) < 0:
    occurences += buses
    
diffs = occurences - minTime
it = np.nditer(diffs, flags=['f_index'])
best = 0

for n in it:
    if n > 0 and n < diffs[best]:
        best = it.index
        
# part 1
print(buses[best] * diffs[best])