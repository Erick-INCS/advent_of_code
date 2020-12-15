#!/usr/bin/env python3
""" Day 12 """
import re

with open('./inputs/inp_day12.txt') as file:
    data = re.findall(r'(\w)(\d+)', file.read())

data = [(r[0], int(r[1])) for r in data]

class Ship():
    def __init__(self, x=0, y=0, direction=(0, 1)):
        self.p = (x, y)
        self.direction = direction
        self.deg = 0

    def deg_to_dir(self, deg):
        deg = deg if type(deg) == str else deg/90 % 4
        if deg == 0 or deg == 'E':
            return (0, 1)
        elif deg == 1 or deg == 'N':
            return (1, 0)
        elif deg == 2 or deg == 'W':
            return (0, -1)
        elif deg == 3 or deg == 'S':
            return (-1, 0)


    def update_dir(self, degrees):
        self.deg = (self.deg + degrees) % 360
        self.direction = self.deg_to_dir(self.deg)
       

    def move(self, val, direction=False):
        d = direction if direction else self.direction
        self.p = (self.p[0] + (d[0] * val), self.p[1] + (d[1] * val))


    def apply(self, action, value):
        if action == "L":
            self.update_dir(value)
        elif action == "R":
            self.update_dir(-value)
        elif action == "B":
            self.move(value, (-self.direction[0], -self.direction[1]))
        elif action == "F":
            self.move(value, self.direction)
        else:
            self.move(value, self.deg_to_dir(action))

t = Ship()
for i in data:
    t.apply(*i)
print(t.direction, t.p, t.deg)
print(abs(t.p[0]) + abs(t.p[1]))
