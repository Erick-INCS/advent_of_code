import scala.io.Source
import scala.collection.mutable.Map

val nums = Source.fromFile("inputs/inp_day15.txt").getLines.mkString.split(",").map((s:String) => s.toInt).toList

var count = 0
var mp = Map[Int, Int]()

nums.foreach(n=> {
  count += 1
  mp += (n -> count)
})

def solve(n2: Int, limit: Int, nums: List[Int]) : Int = {
  var n = n2
  var n_tmp = 0
  count = nums.length
  
  while (count < limit - 1) {
    count += 1

    if (!mp.contains(n)) {
      mp += (n -> count)
      n = 0
    } else {
      n_tmp = count - mp(n)
      mp(n) = count
      n = n_tmp
    }
  }

  return n
}

// part 1
// solve(nums.last, 2020, nums diff List(nums.last))

// part 2
val p2 = () => solve(nums.last, 30000000, nums diff List(nums.last))
