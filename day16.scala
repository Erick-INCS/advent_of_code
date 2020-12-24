import scala.io.Source
import scala.util.matching.Regex

val file = Source.fromFile("./inputs/inp_day16.txt").mkString.split("\n\n")
val regexRule = raw"^(.+): (\d+-\d+) or (\d+-\d+)".r

val readInterval = (s:String) => s.split("-").map(n=>n.toInt).toList

val rules = file(0).split("\n").map((ln) => {
    val nln = regexRule.findAllIn(ln)
    (readInterval(nln.group(2)), readInterval(nln.group(3)), nln.group(1))
})

def validator(n: Integer, data: Array[(List[Int], List[Int], String)]) : Boolean = {
    for (current <- data) {
        if ((n >= current._1(0) && n <= current._1(1)) || (n >= current._2(0) && n <= current._2(1))) return true
    }
    return false
}

def getLabels(n: Integer, data: Array[(List[Int], List[Int], String)]) : Set[String] = {
    var r: Set[String] = Set() 
    for (current <- data) {
        if ((n >= current._1(0) && n <= current._1(1)) || (n >= current._2(0) && n <= current._2(1))) r += current._3 
    }
    return r
}

val near = file(2).split("\n").toList.tail.map(n=>n.split(",").map(s=>s.toInt).toList).filter(ls => {
    ls.map(n => if (!validator(n, rules)) 1 else 0).sum == 0
}).toList

var labels = Array.fill(near(0).length)(rules.map(r=>r._3).toSet)

for (r <- near) {
    for (i <- 0 to r.length - 1) {
        labels(i) = labels(i).intersect(getLabels(r(i),rules))
    }
} 


while (labels.map(i => i.size).max > 1) {
    for (i <- 0 to labels.length - 1) {
        if (labels(i).size == 1) {
            for (ii <- 0 to labels.length - 1 if ii != i) 
                labels(ii) --= labels(i)
        }
    }
}

var r: Long = 1L
for (i <- file(1).split("\n")(1).split(",").map(l => l.toInt).toList.zipWithIndex.filter({
    case (n, i) => {
        labels(i).head.contains("departure")
    }
})) {
    r *= i._1
}

println(r)