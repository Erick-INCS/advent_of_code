import scala.io.Source
import scala.util.matching.Regex

val file = Source.fromFile("./inputs/inp_day16.txt").mkString.split("\n\n")
val regexRule = raw"\w+: (\d+-\d+) or (\d+-\d+)".r

val readInterval = (s:String) => s.split("-").map(n=>n.toInt).toList

val rules = file(0).split("\n").map((ln) => {
    val nln = regexRule.findAllIn(ln)
    (readInterval(nln.group(1)), readInterval(nln.group(2)))
})

val near = file(2).split("\n").toList.tail.map(n=>n.split(",").map(s=>s.toInt).toList)


def validator(n: Integer, data: Array[(List[Int], List[Int])]) : Boolean = {
    for (current <- data) {
        if ((n >= current._1(0) && n <= current._1(1)) || (n >= current._2(0) && n <= current._2(1))) return true
    }
    return false
}

var errores : List[Int] = List()

near.map(ls => {
    for (i <- ls.filter(n => !validator(n, rules))) errores :+= i
}).toList

// Part 1
println(errores.reduce(_+_))