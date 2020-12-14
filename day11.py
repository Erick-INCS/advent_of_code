#!/usr/bin/env python3
import numpy as np

with open("./inp_day11.txt") as file:
    inp = np.array([list(s) for s in list(map(lambda s: s.strip(), file.readlines()))])

VALS = {
    'L' : 1,
    '#' : -1,
    '.' : 0,
}

def travel(arr, pos, part=2):
    ## Part 2 Modification
    if part==2:
        moves = [
            (x, y) for x in range(-1, 2) for y in range(-1, 2)
            if (x,y) != (0,0)
            and x < arr.shape[0] and y < arr.shape[1]
        ]
        directions = []
        for i in moves:
            nPoint = (pos[0] + i[0], pos[1] + i[1])
            while (nPoint[0] >= 0 and nPoint[0] < arr.shape[0]) and (nPoint[1] >= 0 and nPoint[1] < arr.shape[1]):
                
                if VALS[arr[nPoint]] != 0:
                    directions.append(VALS[arr[nPoint]])
                    break
                
                nPoint = (nPoint[0] + i[0], nPoint[1] + i[1])
        return directions
        
    else:
        moves = [
            (x, y) for x in range(pos[0]-1, pos[0]+2) 
            for y in range(pos[1]-1, pos[1]+2)
            if x >= 0 and y >= 0 and (x,y) != pos
            and x < arr.shape[0] and y < arr.shape[1]
        ]
        return list(map(lambda p: VALS[arr[p]], moves))
    
    
def fill(arr, char, part=2):
    copy  = arr.copy()
    it = np.nditer(arr, flags=['multi_index'])
    tolerance = 3 + part
    for _ in it:
        chars = travel(arr, it.multi_index)
        if (VALS[arr[it.multi_index]] != 0) and ((VALS[char] == -1 and chars.count(-1) == 0) or (VALS[char] == 1 and chars.count(-1) >= tolerance)):
            copy[it.multi_index] = char 
    return copy


changed = 1
steps = 0

while changed != 0:
    print("Step", steps + 1)
    
    inp = fill(inp, '#')
    inp2 = fill(inp, 'L')

    changed = np.sum(inp != inp2)
    inp = inp2
    steps += 1

print("ok", np.sum(inp == "#"), "seats after", steps, "steps")
