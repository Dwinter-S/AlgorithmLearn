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
}
