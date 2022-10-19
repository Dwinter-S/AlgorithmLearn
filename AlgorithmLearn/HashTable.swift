//
//  HashTable.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class HashTable {
    // MARK: - 217. 存在重复元素
    /*
     给你一个整数数组 nums 。如果任一值在数组中出现 至少两次 ，返回 true ；如果数组中每个元素互不相同，返回 false。
     
     示例 1：
     输入：nums = [1,2,3,1]
     输出：true
     
     示例 2：
     输入：nums = [1,2,3,4]
     输出：false
     
     示例 3：
     输入：nums = [1,1,1,3,3,4,3,2,4,2]
     输出：true
     
     提示：
     1 <= nums.length <= 105
     -109 <= nums[i] <= 109
     */
    static func containsDuplicate(_ nums: [Int]) -> Bool {
        var map = [Int : Int]()
        for num in nums {
            map[num] = (map[num] ?? 0) + 1
        }
        for (_, value) in map {
            if value != 1 {
                return true
            }
        }
        return false
    }
    
    // MARK: - 633. 平方数之和（中等）
    /*
     给定一个非负整数 c ，你要判断是否存在两个整数 a 和 b，使得 a2 + b2 = c 。
     
     示例 1：
     输入：c = 5
     输出：true
     解释：1 * 1 + 2 * 2 = 5
     
     示例 2：
     输入：c = 3
     输出：false
     
     提示：
     0 <= c <= 231 - 1
     */
    static func judgeSquareSum(_ c: Int) -> Bool {
        var left = 0
        var right = Int(sqrt(Double(c)))
        while left <= right {
            let sum = left * left + right * right
            if sum == c {
                return true
            } else if sum > c {
                right -= 1
            } else {
                left += 1
            }
        }
        return false
    }
    
    // MARK: - 128. 最长连续序列（中等 Hot 100）
    static func longestConsecutive(_ nums: [Int]) -> Int {
        let set = Set(nums)
        var ans = 0
        for num in nums {
            if !set.contains(num - 1) {
                var currentNum = num
                var curCount = 1
                while set.contains(currentNum + 1) {
                    currentNum += 1
                    curCount += 1
                }
                ans = max(ans, curCount)
            }
        }
        return ans
    }
    
    // MARK: - 621. 任务调度器（中等 Hot 100）
    static func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        var countArr = [Int](repeating: 0, count: 26)
        var maxCount = 0
        var maxExcuate = 0
        for task in tasks {
            let index = Int(task.asciiValue! - Character("A").asciiValue!)
            countArr[index] += 1
            if countArr[index] > maxExcuate {
                maxExcuate = countArr[index]
                maxCount = 1
            } else if countArr[index] == maxExcuate {
                maxCount += 1
            }
        }
        return max((maxExcuate - 1) * (n + 1) + maxCount, tasks.count)
    }
}
