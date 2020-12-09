import Data.Set(fromList, intersection)
import System.IO(readFile)
import Data.List.Split

main :: IO()
main = do
    -- Part Two
    f <- readFile "day6_input.txt"
    let file = splitOn "\n\n" f 
    let groups = map (length . foldl1 intersection . map fromList . lines) file
    print $ sum groups