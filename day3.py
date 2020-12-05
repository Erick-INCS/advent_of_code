#!/usr/bin/env python3
""" Advent of code day3 """


def main():
    """ main function """
    with open('day_3_input.txt') as inp:
        mp = list(map(lambda l: l.strip(), inp.readlines()))

    buffer_size = len(mp[0])
    c_x = 0
    c_y = 0

    def step(x, y):
        return (x+1, y+3)

    def callback(c, count):
        if c == '#':
            count += 1
        return count

    counter = 0
    while c_x + step(0, 0)[0] <= len(mp) - 1:
        c_x, c_y = step(c_x, c_y)
        counter = callback(mp[c_x][c_y % buffer_size], counter)

    assert c_x == len(mp) - 1, f'\nc_x[{c_x}] != len(map)[{len(mp) - 1}]'
    assert counter > 0, 'Invalid counter value'

    print(counter)


if __name__ == '__main__':
    main()
