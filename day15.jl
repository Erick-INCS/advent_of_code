#!/usr/bin/env julia

data = parse.(Int, split(readlines("inputs/inp_day15.txt")[1], ","))

cnt = 0
mp = Dict()

for n in data
    global cnt += 1
    global mp
    mp[n] = cnt
end


function solve(n, limit, nums)
    global mp
    n_tmp = 0
    cnt = length(nums)
  
    while (cnt < limit - 1)
        cnt += 1

        if !(haskey(mp, n))
            mp[n] = cnt
            n = 0
        else
            n_tmp = cnt - mp[n]
            mp[n] = cnt
            n = n_tmp
        end
    end
  return n
end

#  part 1
#println(solve(data[end], 2020, data[1:end-1]))

#  part 2
solve(data[end], 30000000, data[1:end-1])
