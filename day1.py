#!/usr/bin/env python3
""" Adventure of code day 2 """

import numpy as np

with open('day_1_input.txt', 'rt') as file:
    nums = file.readlines()
    # nums = nums.split('\n')

nums = np.array(list(map(int, nums)))


for i, n in enumerate(nums):

    current = 2020 - n

    for i2, n2 in enumerate(nums[i+1:]):
        current2 = current - n2

        if current2 <= 0:
            continue

        for i3, n3 in enumerate(nums[i+i2+1:]):
            if current2 - n3 != 0:
                continue

            print(n*n2*n3)
            break
