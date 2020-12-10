import System.IO(readFile)
import Data.List.Split(splitOn)
import Data.Char(isSpace, isDigit)
import Data.Text(isInfixOf, pack)
import Data.Set(fromList, union, toList)
import Debug.Trace ( trace )

clear :: String -> String
clear str = unwords $ filter (not . (`elem`["brings","no","other","bags", "bag", ""])) (words str)

trim :: String -> String
trim = f . f
    where f = reverse . dropWhile isSpace

trimNums :: String -> String
-- for part 1: dropWhile isDigit
trimNums s = s

doubleTrim t = let 
    (c0:c1:_) = t
    trm s = dropWhile isSpace . trimNums . trim $ s
    in [trm c0, trm c1]

splitBags [a, b] = (a, map (trim . trimNums . clear . trim) (splitOn "," b))  

getDirectParents [] colors _ = colors
getDirectParents dt colors myBag = let 
    (h:tl) = dt
    in
        if myBag `isInfixOf` pack (last h) then
        getDirectParents tl (colors ++  [head h]) myBag
        else getDirectParents tl colors myBag

getFullParents src sets = let
    subsets = foldl1 union $ map (fromList . getDirectParents src [] . pack) (toList sets)
    total = sets `union` subsets
    in if length total == length sets
        then sets
        else getFullParents src total




-- functions for part 2
root :: Eq a => a -> [a] -> Bool
root name tp = head tp == name


find :: (Foldable t, Eq (t a)) => t a -> [[t a]] -> [t a]
find nm dt = let 
    fl = filter (root nm) dt
    in if not(null nm)
        then head fl
        else []


mapColor :: [Char] -> (Int, [Char])
mapColor cstring = if not (null cstring) 
    then (read (take 2 cstring)::Int, (drop 2 . trim) cstring)
    else (0, [])


debug :: c -> String -> c
debug = flip trace


getChilds :: [String] -> [(Int, [Char])]
getChilds arr =
    if not (null arr)
    then map (mapColor . trim . clear) ((splitOn "," . trim . clear . last) arr)
    else []


multiplyQuantity :: Num a => a -> (a, b) -> (a, b)
multiplyQuantity n tp = (fst tp * n, snd tp)


expand :: [[[Char]]] -> (Int, [Char]) -> [(Int, [Char])]
expand dt tp = let
    node = find (snd tp) dt
    childs = getChilds node
    in
        map (multiplyQuantity (fst tp)) childs


expandRec :: [[[Char]]] -> [(Int, [Char])] -> [(Int, [Char])] -> Int -> Int
expandRec _ [] [] count = count
expandRec dt [] expds count = expandRec dt expds [] count
expandRec dt lvl expds count = let 
    (current:tail) = lvl
    expanded = expand dt current
    in if length expanded == 1 && (null . snd . head) expanded -- `debug` show count
        then expandRec dt tail expds (count + fst current)
        else expandRec dt tail (expds ++ expanded) count + fst current


main :: IO()
main = do
    fl <- readFile "day7_input.txt"
    let dt =  map (doubleTrim . splitOn "contain" . clear . trim . init) $ lines fl
    -- part 1
    -- let pNodes = getDirectParents dt [] $ pack "shiny gold"
    -- print $ length $ getFullParents dt (fromList pNodes)

    -- part 2
    print $ expandRec dt [(1, "shiny gold")] [] (-1)