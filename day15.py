#!/usr/bin/env pypy

with open("inputs/inp_day15.txt") as data:
    data = [int(n) for n in data.read().strip().split(",")]

count = 0
mp = {} 
for n in data:
    count += 1
    mp[n] = count


def solve(n, limit, nums):
    n_tmp = 0
    count = len(nums)
  
    while (count < limit - 1):
        count += 1

        if not n in mp:
            mp[n] = count
            n = 0
        else:
            n_tmp = count - mp[n]
            mp[n] = count
            n = n_tmp
        print(n)
    return n

#  part 1
print(solve(data[-1], 30, data[:-1]))

#  part 2
# print(solve(data[-1], 30000000, data[:-1]))
