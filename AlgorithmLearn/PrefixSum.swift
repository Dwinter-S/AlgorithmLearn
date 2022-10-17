//
//  PrefixSum.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class PrefixSum {
    
    // MARK: - 560. 和为 K 的子数组（中等 Hot 100）
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        // 直接遍历求和
        /*
        let n = nums.count
        var ans = 0
        for i in 0..<n {
            // 每次循环求以i为子数组末尾的连续子数组数量
            var sum = 0
            // 倒序遍历
            for j in (0...i).reversed() {
                sum += nums[j]
                if sum == k {
                    ans += 1
                }
            }
        }
        return ans
         */
        
        // 前缀和+哈希
        let n = nums.count
        // 存放前缀和和前缀和出现次数
        var map: [Int : Int] = [0 : 1]
        var pre = 0
        var ans = 0
        for i in 0..<n {
            pre += nums[i]
            // 前缀和为pre - k的数量，就等于以i为结尾的和为k的连续子数组的数量。
            if let count = map[pre - k] {
                ans += count
            }
            map[pre] = (map[pre] ?? 0) + 1
        }
        return ans
    }
    
}
