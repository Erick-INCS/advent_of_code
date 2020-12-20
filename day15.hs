import System.IO(readFile)
import Data.List.Split(splitOn)
import Data.Map(fromList, insert, Map, member, alter, (!))
-- import Debug.Trace ( trace )
-- ebug = flip trace

enumMp :: [Int] -> Map Int Int
enumMp arr = startMp arr 1 (fromList [])

startMp :: [Int] -> Int -> Map Int Int -> Map Int Int
startMp arr i mp = let
  (h:t) = arr
  in
    if null t then mp
    else startMp t (i+1) (insert h i mp) 

solve :: Int -> [Int] -> Int
solve limit nums = let
  mp = enumMp nums
  in
    solveFull limit mp (length nums) (last nums)

solveFull :: Int -> Map Int Int -> Int -> Int -> Int
solveFull limit mp c current
  | c == limit              = current
  | not (member current mp) = solveFull limit (insert current c mp) (c + 1) 0
  | otherwise               = solveFull limit (alter (\ _ -> Just c) current mp) (c + 1) (c - (mp ! current))

main :: IO()
main = do
  fl <- readFile "inputs/inp_day15.txt"
  let ns = map read $ splitOn "," (init fl)::[Int]
  print $ solve 30000000 ns
