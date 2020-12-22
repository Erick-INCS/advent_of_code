#!/usr/bin/env scala

import scala.io.Source

val nums = Source.fromFile("inputs/inp_day15.txt").getLines.mkString.split(",").map((s:String) => s.toInt).toList

def solve(limit: Int, nums: List[Int]) : Int = {
  
  var n = 0
  var tmp = 0
  val arr = Array.fill(limit)(0)
  
  for (i <- 1 to nums.length) {
    arr(nums(i - 1)) = i
  }
  
  n = nums.last
  for (i <- nums.length to limit - 1) {
    tmp = arr(n)
    arr(n) = i
    n = if (tmp == 0) 0 else i - tmp
  }

  return n
}

// part 1
// solve(nums.last, 2020, nums diff List(nums.last))

// part 2
val p2 = () => solve(30000000, nums)
// println(p2())