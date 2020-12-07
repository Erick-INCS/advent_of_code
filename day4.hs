import System.IO
import Data.List.Split

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

setProp prop obj =
  case prop of
    "byr" -> obj{byr=True}
    "iyr" -> obj{iyr=True}
    "eyr" -> obj{eyr=True}
    "hgt" -> obj{hgt=True}
    "hcl" -> obj{hcl=True}
    "ecl" -> obj{ecl=True}
    "pid" -> obj{pid=True}
    _ -> obj

validatePassport ps = if (byr ps) && (iyr ps) && (eyr ps) && (hgt ps) && (hcl ps) && (ecl ps) && (pid ps) then 1 else 0
getProps str = map (head . (splitOn ":")) $ words str
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

-- valdation
dt = [ "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd" ,"byr:1937 iyr:2017 cid:147 hgt:183cmm", "", "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884", "hcl:#cfa07d byr:1929", "","hcl:#ae17e1 iyr:2013", "eyr:2024", "ecl:brn pid:760753108 byr:1931", "hgt:179cm", "", "hcl:#cfa07d eyr:2025 pid:166559648", "iyr:2011 ecl:brn hgt:59in"]


main :: IO()
main = do
  file <- readFile "day4_input.txt"
  let f = lines file

  let res = validate f nullP 0

  putStrLn . show $ res
