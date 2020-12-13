#!/usr/bin/env python3
import numpy as np
import sys
np.set_printoptions(threshold=sys.maxsize)

with open("./inp_day11.txt") as file:
    inp = np.array([list(s) for s in list(map(lambda s: s.strip(), file.readlines()))])

VALS = {
    'L' : 1,
    '#' : -1,
    '.' : 0,
}

def travel(arr, pos):
    moves = [
        (x, y) for x in range(pos[0]-1, pos[0]+2) 
        for y in range(pos[1]-1, pos[1]+2)
        if x >= 0 and y >= 0 and (x,y) != pos
        and x < arr.shape[0] and y < arr.shape[1]
    ]

    return list(map(lambda p: VALS[arr[p]], moves))
    
def fill(arr, char):
    copy  = arr.copy()
    it = np.nditer(arr, flags=['multi_index'])
    for _ in it:
        chars = travel(arr, it.multi_index)
        if (VALS[arr[it.multi_index]] != 0) and ((VALS[char] == -1 and chars.count(-1) == 0) or (VALS[char] == 1 and chars.count(-1) >= 4)):
            copy[it.multi_index] = char 
    return copy

changed = 1
steps = 0

while changed != 0:
    inp = fill(inp, '#')
    inp2 = fill(inp, 'L')

    changed = np.sum(inp != inp2)
    inp = inp2
    steps += 1

print("ok", np.sum(inp == "#"), "seats after", steps, "steps")
