//
//  DP.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/9/5.
//

import Foundation

class DP {
    // MARK: - 53. 最大子数组和（中等）
    static func maxSubArray(_ nums: [Int]) -> Int {
        // 标准dp
        /*
        let len = nums.count
        // dp[i]表示0...i范围内的最大子数组和
        var dp = [Int](repeating: 0, count: len)
        dp[0] = nums[0]
        for i in 1..<len {
            if dp[i - 1] > 0 {
                dp[i] = dp[i - 1] + nums[i]
            } else {
                dp[i] = nums[i]
            }
        }
        return dp.max()!
         */
        
        // dp空间优化
        var maxSum = nums[0]
        // pre表示dp[i-1]
        var pre = 0
        for num in nums {
            pre = max(num, num + pre)
            maxSum = max(maxSum, pre)
        }
        return maxSum
    }
    
    // MARK: - 62. 不同路径（中等）
    static func uniquePaths(_ m: Int, _ n: Int) -> Int {
        // 标准dp
        /*
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0..<m {
            dp[i][0] = 1
        }
        for i in 0..<n {
            dp[0][i] = 1
        }
        for i in 1..<m {
            for j in 1..<n {
                dp[i][j] = dp[i-1][j] + dp[i][j-1]
            }
        }
        return dp[m - 1][n - 1]
         */
        
        // dp空间优化
        var cur = [Int](repeating: 1, count: m)
        var pre = [Int](repeating: 1, count: m)
        for 
    }
}
