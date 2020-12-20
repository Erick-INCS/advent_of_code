#!/usr/bin/env python3
import numpy as np
from sympy.ntheory.modular import solve_congruence

with open("./inputs/inp_day13.txt") as file:
    inp = file.read().split('\n')

minTime = int(inp[0])
buses = np.array([n for n in inp[1].split(',') if not n in ['x', '']], dtype=np.int64)
# del inp ## uncommented in part 2

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

# part 2
print(solve_congruence(*[(-i, int(n)) for i, n in enumerate(inp[1].split(',')) if n != 'x'])[0])