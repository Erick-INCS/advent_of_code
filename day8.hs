import System.IO(readFile)

format :: [String] -> [(String, Int)]
format str = let 
    fmt dt = (head dt, read (last dt)::Int)
    in map (fmt . words . clean) str

clean :: String -> String
clean s = let 
    cl '+' = '0'
    cl c = c
    in map cl s

exec :: (String, Int) -> (Int, Int)-> (Int, Int)
exec tp state = let 
    nm  = fst tp
    val = snd tp
    indx = fst state
    acc = snd state
    in case nm of
        "acc" -> (indx + 1, val + acc)
        "jmp" -> (indx + val, acc)
        _ -> (indx + 1, acc)

run :: [(String, Int)] -> (Int, Int) -> [Int] -> Int
run dt (indx, acc) indexes = let
    current = dt!!indx
    in if indx `elem` indexes
        then acc
        else
            run dt (exec current (indx, acc)) (indexes ++ [indx])

main :: IO()
main = do
    file <- readFile "./day8_input.txt"
    let f = format . lines $ file 
    
    print $ run f (0,0) []