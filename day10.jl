data = readlines("./inp_day10.txt")
data = sort(parse.(Int, data))

difs = data[1 : end-1] .-  data[2:end]

# part 1
println(difs)
println((sum(difs.==-1) + 1) * (sum(difs.==-3) + 1))