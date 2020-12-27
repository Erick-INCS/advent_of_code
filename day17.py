#!/usr/bin/env python3
""" Day 17 """
from itertools import product

with open("inputs/inp_day17.txt", 'r') as file:
    dt = file.read().split("\n")

ps = tuple(
    (x, y, 0)
    for y, l in enumerate(dt)
    for x, c in enumerate(l) if c == "#")

trans = list(product((-1, 0, 1), repeat=3))
trans.remove((0,)*3)


def expand(p):
    for i in trans:
        yield (p[0] + i[0], p[1] + i[1], p[2] + i[2])


for _ in range(6):
    new = set()
    for ac in ps:

        for point in expand(ac):
            act_ne = len([p for p in expand(point) if p in ps])

            if (act_ne in [2, 3]) and (point in ps):
                new.add(point)
            elif (act_ne == 3) and (point not in ps):
                new.add(point)
        act_ne = len([p for p in expand(ac) if p in ps])
        if act_ne == 3:
            new.add(ac)
    ps = tuple(new)

print(len(ps))
