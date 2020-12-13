data = readlines("./inp_day10.txt")
data = sort(parse.(Int, data))

diffs = [0 ; data] .-  [data ; data[end] + 3]

# part 1
#println(sum(diffs.==-1) * sum(diffs.==-3))

# part 2
function ps(n, arr)
    filter(e-> e in arr, n-3:n+3)
end

total = 0

function func(n, arr, acc=[], stop=maximum(arr))
    a = copy(arr)
    p = ps(n, a)
    acom = copy(acc)

    for i in p
        npmA = copy(a)
        npmA = deleteat!(npmA, findfirst(l->l==i, npmA))
        func(i, npmA, [acom; i], stop)
    end
    if n == stop
        global total += 1
    end
end

testData = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4, 22]
# testData = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]
testData = sort(testData)

func(0, testData, [], testData[end])
println(total)

# println(describe(data[1], ))