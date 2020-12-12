import System.IO(readFile)
import Debug.Trace ( trace )

debug = flip trace

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

invert :: String -> String
invert s = case s of
    "jmp" -> "nop"
    "nop" -> "jmp"
    _ -> s

trd :: (a, b, c) -> c
trd (_, _, t) = t



runp2 :: [(String, Int)] -> (Int, Int) -> [Int] -> ((Int, Int), Int) -> [Int] -> Bool -> Int
runp2 dt (indx, acc) indexes lastExecution chgIndxs changed
    | indx `elem` indexes && changed = runp2 dt (0,0) [] ((0,0),0) (chgIndxs ++ [snd lastExec]) False
    | indx `elem` indexes = runp2 dt (fst lastExec) (filter (/= snd lastExec) indexes) lastExec chgIndxs True -- `debug` ("inv exec " ++ show (invert (fst current), snd current))
    | indx == length dt = acc
    | otherwise = runp2 dt (exec current (indx, acc)) (indexes ++ [indx]) lastExec chgIndxs changed
    where 
        current = dt!!indx
        lastExec = if fst current `elem` ["jmp", "nop"] && notElem indx chgIndxs
            then (exec (invert (fst current), snd current) (indx, acc), indx) -- `debug` show (invert (fst current), snd current, current, fst current)
            else lastExecution


main :: IO()
main = do
    file <- readFile "./inp_day8.txt"
    let f = format . lines $ file 
    
    -- part 1 
    -- print $ run f (0,0) []
    
    -- part 2 
    print $ runp2 f (0,0) [] ((0,0),0) [] False