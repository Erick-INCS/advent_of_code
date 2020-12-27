#!/usr/bin/env python3
""" Day 18 """

with open("./inputs/inp_day18.txt") as file:
    dt = [s.replace(' ', '') for s in file.read().split('\n')]

OP =  {
    '+': lambda a, b: int(a) + int(b),
    '*': lambda a, b: int(a) * int(b)
}

"""
dt = [
    '2*3+(4*5)',
    '5+(8*3+9+3*4*3)',
    '5*9*(7*3*3+9*3+(8+6*4))',
    '((2+4*9)*(6+9*8+6)+6)+2+4*2'
    ]
"""

total = 0
for e in dt:
    seq = []
    mem = [0]
    last = ''
    op = ''
    acc = 0

    for c in e:
        if (c not in '()') and (c not in OP):
            if op:
                mem[-1] = OP[op](mem[-1], c)
            else:
                mem[-1] = int(c)

        elif c in OP:
            op = c

        elif c == '(':
            mem.append(0)
            seq.append(op)
            op = ''
        else:
            op = seq.pop()
            mem_value = mem.pop()
            if op:
                mem[-1] = OP[op](mem[-1], mem_value)
            else:
                assert mem[-1] == 0
                mem[-1] = mem_value

    assert len(seq) == 0
    total += mem.pop()
    print(total)