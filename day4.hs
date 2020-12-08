import System.IO
import Data.List.Split
import Text.Read
import Text.Regex(mkRegex, matchRegex)

data Passport =
  Passport {
      byr :: Bool,
      iyr :: Bool,
      eyr :: Bool,
      hgt :: Bool,
      hcl :: Bool,
      pid :: Bool,
      ecl :: Bool
    }

nullP = Passport False False False False False False False

setProp prop obj
  | prp == "byr" && (let y = read val :: Int in y >= 1920 && y <= 2002) = obj{byr=True}
  | prp == "iyr" && (let y = read val :: Int in y >= 2010 && y <= 2020) = obj{iyr=True}
  | prp == "eyr" && (let y = read val :: Int in y >= 2020 && y <= 2030) = obj{eyr=True}
  | prp == "hgt" && (let 
                        um  = (reverse . (take 2)) (reverse val)
                        in
                          case readMaybe (take ((length val) - 2) val) :: Maybe Float of
                            Just n  -> if (um == "cm") then (n >= 150 && n <= 193) else (if um == "in" then n >= 59 && n <= 76 else False)
                            Nothing -> False
                    ) = obj{hgt=True}

  | prp == "hcl" && (matchRegex (mkRegex "^#[0-9a-f]{6}$") val)             /= Nothing = obj{hcl=True}
  | prp == "ecl" && (matchRegex (mkRegex "^amb$|^blu$|^brn$|^gry$|^grn$|^hzl$|^oth$") val) /= Nothing = obj{ecl=True}
  | prp == "pid" && (matchRegex (mkRegex "^[0-9]{9}$") val) /= Nothing = obj{pid=True}
  | otherwise    = obj
  where (prp : val : _) = prop

validatePassport ps = if (byr ps) && (iyr ps) && (eyr ps) && (hgt ps) && (hcl ps) && (ecl ps) && (pid ps) then 1 else 0
getProps str = map (splitOn ":") $ words str
setProps obj props =
  let (h : tl) = props
  in 
    if tl == [] then setProp h obj
    else setProps (setProp h obj) tl

validate [] obj counter = counter + validatePassport obj
validate doc obj counter =
  let 
    (h:tl) = doc
  in
    if length h == 0 then
      validate tl nullP (counter + validatePassport obj)
    else
      validate tl ((setProps obj) (getProps h)) counter

main :: IO()
main = do
  file <- readFile "day4_input.txt"
  let f = lines file

  let res = validate f nullP 0

  putStrLn . show $ res
