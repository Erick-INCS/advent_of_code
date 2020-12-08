# Read the data
data = readlines("day5_input.txt")

rows = 127
cols = 7

function decodeChar(ch :: Char)

  ch = uppercase(ch)
  ch in ['F', 'L'] && return 0
  ch in ['B', 'R'] && return 1
end


function getCoords(encoded :: String, verbose::Bool=false) 
  col, row = encoded[end-2:end], encoded[1:end-3]
  x, y = [0, rows], [0, cols]

  (getCoord(x, row, verbose), getCoord(y, col, verbose))
end


function getCoord(cords, encoding, verbose=false) 
  c = ' '
  while length(encoding) > 0
    c = encoding[1]
    encoding = encoding[2:end]

    cords[2-decodeChar(c)] = (decodeChar(c) == 0 ? floor : round)(Int, cords[2] - ((cords[2]-cords[1]) / 2))
  
    if verbose
      println(c, " --> ", cords)
    end
    
  end

  cords[1 + decodeChar(c)]
end

idFunc = t -> t[1] * 8 + t[2] 
cords = map(getCoords, data)
ids = map(idFunc, cords)

println("Maximum ID:\t", maximum(ids))




# Part 2 --------

seats = zeros(Int8, rows + 1, cols + 1)

for i in cords
  seats[i[1] + 1, i[2] + 1] = 1
end


options = []
center = (rows/2, cols/2)
distanceFunc = t -> sqrt((center[2]-t[2])^2 + (center[1]-t[1])^2)

for r=1:(rows+1)
  for c=1:(cols+1)
    currentPoint = (r-1,c-1)
    if (seats[r,c] == 0) && (idFunc(currentPoint) - 1 in ids) && (idFunc(currentPoint)+1 in ids)
      append!(options, [(idFunc(currentPoint), distanceFunc(currentPoint),)])
    end
  end
end

mn = options[1]

for i in options
  if i[2] < mn[2]
    global mn = i
  end
end

println("Seat (because has the minimum distance to the center): ", mn[1])
