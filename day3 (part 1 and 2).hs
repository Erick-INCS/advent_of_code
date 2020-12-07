-- Day 3

import System.IO

-- Make a step
slopStepX x slp = x + fst slp
slopStepY y slp = y + snd slp

applySlope p slp = (slopStepX (fst p) slp, slopStepY (snd p) slp)

-- get specific char of a map
getCharOfMap map point = map !! (fst point) !! mod (snd point) (length (map!!0))

-- validate a point
validPoint map point = fst point < length map

-- values of the trees sum
charVal ch =
  case ch of
  '#' -> 1
  _   -> 0

-- get the count of trees
trees mp p count slp =
  if validPoint mp p then
    trees mp (applySlope p slp) (count + charVal (getCharOfMap mp p)) slp
  else
    count

-- main function
main :: IO()
main = do
  -- read map file
  file <- readFile "day3_input.txt"
  let lns = lines file

  -- cal the number of trees by the slops (1, 1), (3, 1), (5, 1), (7, 1) and (1, 2)
  let slops = map (trees lns (0, 0) 0) [(1, 1), (1, 3), (1, 5), (1, 7), (2, 1)]

  -- all the slops
  putStrLn . show $ slops
  putStrLn . show . product $ slops
