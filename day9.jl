data = readlines("./inp_day9.txt")
data = map(n -> parse(Int, n), data)

batchSize = 25

function valid(arr, num)
    for i in 1:length(arr)
        for ii in i+1:length(arr)
            if arr[i] != arr[ii] && arr[i]+arr[ii] == num
                return true
            end
        end
    end
    false
end

invalid = -1
for i=batchSize+1:length(data)-1
    global invalid
    if !valid(data[i-batchSize:i], data[i+1])
        invalid = data[i+1]
        break
    end
end

## find range
fi, li = 1, 1
acc = -1
while acc != invalid
    global li += 1
    global fi
    global acc = sum(data[fi:li])
    if acc > invalid
        fi += 1
        li = fi
        acc = -1
    end
end

# slice = sort(data[fi:li])

println(maximum(data[fi:li])+minimum(data[fi:li]))