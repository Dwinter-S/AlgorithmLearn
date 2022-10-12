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
        /*
         var cur = [Int](repeating: 1, count: n)
         var pre = [Int](repeating: 1, count: n)
         for i in 1..<m {
         for j in 1..<n {
         cur[j] = pre[j] + cur[j-1]
         }
         pre = cur
         }
         return pre[n-1]
         */
        var cur = [Int](repeating: 1, count: n)
        for i in 1..<m {
            for j in 1..<n {
                cur[j] += cur[j-1]
            }
        }
        return cur[n-1]
    }
    
    // MARK: -64. 最小路径和（中等）
    static func minPathSum(_ grid: [[Int]]) -> Int {
        // 标准dp
        /*
         let row = grid.count
         let col = grid[0].count
         var dp = [[Int]](repeating: [Int](repeating: 0, count: col), count: row)
         dp[0][0] = grid[0][0]
         for i in 1..<row {
         dp[i][0] = dp[i-1][0] + grid[i][0]
         }
         for j in 1..<col {
         dp[0][j] = dp[0][j-1] + grid[0][j]
         }
         for i in 1..<row {
         for j in 1..<col {
         dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + grid[i][j]
         }
         }
         return dp[row-1][col-1]
         */
        // 空间优化
        let row = grid.count
        let col = grid[0].count
        var cur = [Int](repeating: 0, count: col)
        cur[0] = grid[0][0]
        for i in 1..<col {
            cur[i] = cur[i-1] + grid[0][i]
        }
        for i in 1..<row {
            // cur[0]代表第i行0列的最小路径和
            cur[0] = cur[0] + grid[i][0]
            for j in 1..<col {
                cur[j] = min(cur[j], cur[j-1]) + grid[i][j]
            }
        }
        return cur[col-1]
    }
    
    // MARK: - 70. 爬楼梯
    static func climbStairs(_ n: Int) -> Int {
        // dp数组
        /*
         if n < 3 { return n }
         var dp = [Int](repeating: 0, count: n)
         dp[0] = 1
         dp[1] = 2
         for i in 2..<n {
         dp[i] = dp[i-1] + dp[i-2]
         }
         return dp[n - 1]
         */
        
        // 滚动数组优化空间
        var res = 1
        // pre代表n-2的台阶，cur代表n-1级台阶
        var pre = 0
        var cur = 0
        for i in 1...n {
            pre = cur
            cur = res
            res = pre + cur
        }
        return res
    }
    
    // MARK: - 1143. 最长公共子序列（中等）
    static func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let text1Chars = Array(text1)
        let text2Chars = Array(text2)
        let textlLen = text1Chars.count
        let text2Len = text2Chars.count
        // dp[i][j]表示text1[0..<i]和text2[0..<j]的最长公共子序列
        var dp = [[Int]](repeating: [Int](repeating: 0, count: text2Len + 1), count: textlLen + 1)
        for i in 1..<textlLen+1 {
            for j in 1..<text2Len+1 {
                if text1Chars[i-1] == text2Chars[j-1] {
                    dp[i][j] = dp[i-1][j-1] + 1
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                }
            }
        }
        return dp[textlLen][text2Len]
    }
    
    // MARK: - 1277. 统计全为 1 的正方形子矩阵（中等）
    static func countSquares(_ matrix: [[Int]]) -> Int {
        var rows = matrix.count
        var cols = matrix[0].count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)
        dp[0][0] = matrix[0][0] == 1 ? 1 : 0
        for i in 1..<rows {
            dp[i][0] = dp[i-1][0] + (matrix[i][0] == 1 ? 1 : 0)
        }
        for j in 1..<cols {
            dp[0][j] = dp[0][j-1] + (matrix[0][j] == 1 ? 1 : 0)
        }
        for i in 1..<rows {
            for j in 1..<cols {
                if matrix[i][j] == 0 {
                    dp[i][j] = dp[i-1][j] + dp[i][j-1] - dp[i-1][j-1]
                } else {
                    var add = 0
                    var curI = i; var curJ = j
                    while curI >= 0 && curJ >= 0 {
                        var isAdd = true
                        for x in curI...i {
                            for y in curJ...j {
                                if matrix[x][y] != 1 {
                                    isAdd = false
                                    break
                                }
                            }
                        }
                        if isAdd {
                            add += 1
                        } else {
                            break
                        }
                        curI -= 1
                        curJ -= 1
                    }
                    dp[i][j] = dp[i-1][j] + dp[i][j-1] - dp[i-1][j-1] + add
                }
            }
        }
        return dp[rows-1][cols-1]
    }
    
    // MARK: - 343. 整数拆分（中等）
    static func integerBreak(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n + 1)
        dp[2] = 1
        for i in 3...n {
            for j in 2..<i {
                dp[i] = max(dp[i], max(j * (i - j), j * dp[i - j]))
            }
        }
        return dp[n]
    }
    
    // MARK: - 96. 不同的二叉搜索树（中等）
    static func numTrees(_ n: Int) -> Int {
        var dp = Array(repeating: 0, count: n + 1)
        dp[0] = 1
        for i in 1...n {
            for j in  1...i {
                // dp[i]等于以1到i为根节点二叉搜索树的数量总和,以j为根节点的二叉搜索树的数量等于j-1和i-j个节点组成的数量的乘积
                dp[i] += dp[j - 1] * dp[i - j]
            }
        }
        return dp[n]
        
    }
    
    // MARK: - 416. 分割等和子集（中等）
    func canPartition(_ nums: [Int]) -> Bool {
        let n = nums.count
        let maxSum = 100 * n + 1
        var sum = 0
        var dp = [Int](repeating: 0, count: maxSum)
        for num in nums {
            sum += num
        }
        
        guard sum % 2 == 0 else { return false }
        for i in 0..<n {
            var j = sum / 2
            while j >= nums[i] {
                dp[j] = max(dp[j], dp[j - nums[i]] + nums[i])
                j -= 1
            }
        }
        return dp[sum / 2] == sum / 2
        
    }
    
    // MARK: - 139. 单词拆分（中等 Hot 100）
    static func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        // 回朔法，超时了
        /*
        func backtracking(_ chars: [Character], _ wordDict: [String], startIndex: Int) -> Bool {
            for word in wordDict {
                let targetIndex = startIndex + word.count
                if targetIndex > chars.count {
                    continue
                }
                let matchWord = String(chars[startIndex..<targetIndex])
                if word == matchWord {
                    if startIndex + word.count == chars.count {
                        return true
                    } else {
                        let isMatched = backtracking(chars, wordDict, startIndex: startIndex + word.count)
                        if isMatched {
                            return true
                        }
                    }
                }
            }
            return false
        }
        return backtracking(Array(s), wordDict, startIndex: 0)
         */
        
        // 动态规划
        // dp表示以[0,n)的子串是否能够被字典中的字符串拼接出。
        let n = s.count
        var dp = [Bool](repeating: false, count: n + 1)
        dp[0] = true
        let wordSet = Set(wordDict)
        for i in 1...n {
            for j in 0..<i {
                // [0,j)的子串可以拼接出，并且[j,i)的子串包含在字典中，则[0,i)的子串也可以拼接出
                if dp[j] && wordSet.contains(String(Array(s)[j..<i])) {
                    dp[i] = true
                    break
                }
            }
        }
        
        return dp[n]
    }

    // MARK: - 152. 乘积最大子数组（中等 Hot 100）
    static func maxProduct(_ nums: [Int]) -> Int {
        // dp[i]表示以下标i结尾的子数组，包含下标i的最大乘积
        var maxValue = nums[0]
        var minValue = nums[0]
        var ans = nums[0]
        for i in 1..<nums.count {
            let t = maxValue
            maxValue = max(max(nums[i], nums[i] * minValue), nums[i] * maxValue)
            minValue = min(min(nums[i], nums[i] * minValue), nums[i] * t)
            ans = max(maxValue, ans)
        }
        return ans
    }
    
        
    // MARK: - 279. 完全平方数（中等 Hot 100）
    static func numSquares(_ n: Int) -> Int {
        // dp[i]表示组成i的完全平方数的最小个数
        var dp = [Int](repeating: 0, count: n + 1)
        for i in 1...n {
            var j = 1
            var minValue = Int.max
            while j * j <= i {
                minValue = min(minValue, dp[i - j * j])
                j += 1
            }
            dp[i] = minValue + 1
        }
        return dp[n]
    }
    
    // MARK: - 322. 零钱兑换（中等 Hot 100）
    static func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard amount > 0 else { return 0 }
        var dp = [Int](repeating: Int.max, count: amount + 1)
        // 凑成0元需要0个硬币
        dp[0] = 0
        for i in 1...amount {
            for j in 0..<coins.count {
                if coins[j] <= i, dp[i - coins[j]] != Int.max {
                    dp[i] = min(dp[i], dp[i - coins[j]] + 1)
                }
            }
        }
        // dp[amount] == Int.max 代表凑不出amount元
        return dp[amount] == Int.max ? -1 : dp[amount]
    }
    
    // MARK: - 309. 最佳买卖股票时机含冷冻期（中等 Hot 100）
    static func maxProfit(_ prices: [Int]) -> Int {
        /*
         dp[i][j]：表示第i天操作股票后j状态的最大利润
         dp[i][0]: 第i天持有股票状态的最大利润，如果第i天没有买入股票，则为第i-1天持有股票的最大利润；如果第i天买入股票，则为第i-1天卖出股票没有处于冷冻期状态的最大利润减去股票价格。
         dp[i][1]: 第i天不持有股票并且处于冷冻期状态的最大利润，即第i天卖出股票，为第i-1天持有股票的最大利润加上卖出股票的价格。
         dp[i][2]: 第i天不持有股票并且不处于冷冻期状态的最大利润，为第i-1天就不持有股票并且不处于冷冻期状态的最大利润和第i-1天不持有股票并且处于冷冻期状态的最大利润中的较大值。
         */
        let n = prices.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: n)
        dp[0][0] = -prices[0]
        for i in 1..<n {
            dp[i][0] = max(dp[i - 1][0], dp[i - 1][2] - prices[i])
            dp[i][1] = dp[i - 1][0] + prices[i]
            dp[i][2] = max(dp[i - 1][1], dp[i - 1][2])
        }
        
        return max(dp[n - 1][1], dp[n - 1][2])
    }
    
    
    // MARK: - 337. 打家劫舍 III（中等 Hot 100）
    static func rob(_ root: TreeNode?) -> Int {
        // 数组第一位表示偷当前节点的最大利润，第二位表示不偷当前节点的最大利润
        func robTree(_ root: TreeNode?) -> [Int] {
            guard let root = root else { return [0, 0] }
            let left = robTree(root.left)
            let right = robTree(root.right)
            // 偷当前节点，左右子节点都不能偷
            let val1 = root.val + left[1] + right[1]
            // 不偷当前节点，左右节点偷和不偷都可以，取最大值
            let val2 = max(left[0], left[1]) + max(right[0], right[1])
            return [val1, val2]
        }
        let res = robTree(root)
        return max(res[0], res[1])
    }
}

