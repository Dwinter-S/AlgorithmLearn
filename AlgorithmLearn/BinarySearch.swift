//
//  BinarySearch.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class BinarySearch {
    // MARK: - 374.猜数字大小
    /*
    猜数字游戏的规则如下：

    每轮游戏，我都会从 1 到 n 随机选择一个数字。 请你猜选出的是哪个数字。
    如果你猜错了，我会告诉你，你猜测的数字比我选出的数字是大了还是小了。
    你可以通过调用一个预先定义好的接口 int guess(int num) 来获取猜测结果，返回值一共有 3 种可能的情况（-1，1 或 0）：

    -1：我选出的数字比你猜的数字小 pick < num
    1：我选出的数字比你猜的数字大 pick > num
    0：我选出的数字和你猜的数字一样。恭喜！你猜对了！pick == num
    返回我选出的数字。
     
    输入：n = 10, pick = 6
    输出：6
     
    示例 2：
    输入：n = 1, pick = 1
    输出：1
     
    示例 3：
    输入：n = 2, pick = 1
    输出：1
     
    示例 4：
    输入：n = 2, pick = 2
    输出：2
    提示：
    1 <= n <= 231 - 1
    1 <= pick <= n
     */
//    static func guessNumber(_ n: Int) -> Int {
//        var left = 1
//        var right = n
//        while left < right {
//            let mid = left + (right - left) / 2
//            if guess(mid) == 0 {
//                return mid
//            } else if guess(mid) > 0 {
//                left = mid + 1
//            } else if guess(mid) < 0 {
//                right = mid - 1
//            }
//        }
//        return left
//    }
    
    // MARK: - 35.搜索插入位置
    /*
     给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
     请必须使用时间复杂度为 O(log n) 的算法。
     
     示例 1:
     输入: nums = [1,3,5,6], target = 5
     输出: 2
     
     示例 2:
     输入: nums = [1,3,5,6], target = 2
     输出: 1
     
     示例 3:
     输入: nums = [1,3,5,6], target = 7
     输出: 4
     
     提示:
     1 <= nums.length <= 104
     -104 <= nums[i] <= 104
     nums 为 无重复元素 的 升序 排列数组
     -104 <= target <= 104
     */
    static func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            }
        }
        return left
    }
    
    // MARK: - 278.第一个错误的版本
    /*
     你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。
     假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
     你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。

     示例 1：
     输入：n = 5, bad = 4
     输出：4
     解释：
     调用 isBadVersion(3) -> false
     调用 isBadVersion(5) -> true
     调用 isBadVersion(4) -> true
     所以，4 是第一个错误的版本。
     
     示例 2：
     输入：n = 1, bad = 1
     输出：1
     
     提示：
     1 <= bad <= n <= 231 - 1
     */
//    static func firstBadVersion(_ n: Int) -> Int {
//        var left = 1
//        var right = n
//        while left <= right {
//            let mid = left + (right - left) / 2
//            if isBadVersion(mid) {
//                right = mid - 1
//            } else {
//                left = mid + 1
//            }
//        }
//        return left
//    }
    
    // MARK: - 367. 有效的完全平方数
    /*
     给定一个 正整数 num ，编写一个函数，如果 num 是一个完全平方数，则返回 true ，否则返回 false 。
     进阶：不要 使用任何内置的库函数，如  sqrt 。
     
     示例 1：
     输入：num = 16
     输出：true
     
     示例 2：
     输入：num = 14
     输出：false
     
     提示：
     1 <= num <= 2^31 - 1
     */
    static func isPerfectSquare(_ num: Int) -> Bool {
        var left = 0
        var right = num
        while left <= right {
            let mid = left + (right - left) / 2
            if mid * mid == num {
                return true
            } else if mid * mid > num {
                right = mid - 1
            } else if mid * mid < num {
                left = mid + 1
            }
        }
        return false
    }
    
    // MARK: - 69.x 的平方根
    /*
     给你一个非负整数 x ，计算并返回 x 的 算术平方根 。
     由于返回类型是整数，结果只保留 整数部分 ，小数部分将被 舍去 。
     注意：不允许使用任何内置指数函数和算符，例如 pow(x, 0.5) 或者 x ** 0.5 。
     
     示例 1：
     输入：x = 4
     输出：2
     
     示例 2：
     输入：x = 8
     输出：2
     解释：8 的算术平方根是 2.82842..., 由于返回类型是整数，小数部分将被舍去。
     
     提示：
     0 <= x <= 231 - 1
     */
    static func mySqrt(_ x: Int) -> Int {
        var left = 0
        var right = x
        while left <= right {
            let mid = left + (right - left) / 2
            if mid * mid == x {
                return mid
            } else if mid * mid > x {
                right = mid - 1
            } else if mid * mid < x {
                left = mid + 1
            }
        }
        return right
    }
    
    // MARK: - 441.排列硬币
    /*
     你总共有 n 枚硬币，并计划将它们按阶梯状排列。对于一个由 k 行组成的阶梯，其第 i 行必须正好有 i 枚硬币。阶梯的最后一行 可能 是不完整的。
     给你一个数字 n ，计算并返回可形成 完整阶梯行 的总行数。
     
     示例 1：
     输入：n = 5
     输出：2
     解释：因为第三行不完整，所以返回 2 。
     
     示例 2：
     输入：n = 8
     输出：3
     解释：因为第四行不完整，所以返回 3 。
     
     提示：
     1 <= n <= 231 - 1
     */
    static func arrangeCoins(_ n: Int) -> Int {
        var left = 0
        var right = n
        while left <= right {
            let mid = left + (right - left) / 2
            let total = (1 + mid) * mid / 2
            if total == n {
                return mid
            } else if total > n {
                right = mid - 1
            } else if total < n {
                left = mid + 1
            }
        }
        return right
    }
    
    // MARK: - 34.在排序数组中查找元素的第一个和最后一个位置 (中等)
    /*
     给你一个按照非递减顺序排列的整数数组 nums，和一个目标值 target。请你找出给定目标值在数组中的开始位置和结束位置。
     如果数组中不存在目标值 target，返回 [-1, -1]。
     你必须设计并实现时间复杂度为 O(log n) 的算法解决此问题。
     
     示例 1：
     输入：nums = [5,7,7,8,8,10], target = 8
     输出：[3,4]
     
     示例 2：
     输入：nums = [5,7,7,8,8,10], target = 6
     输出：[-1,-1]
     
     示例 3：
     输入：nums = [], target = 0
     输出：[-1,-1]
     
     提示：
     0 <= nums.length <= 105
     -109 <= nums[i] <= 109
     nums 是一个非递减数组
     -109 <= target <= 109
     */
    static func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target {
                var start = mid
                var end = mid
                while start - 1 >= 0, nums[start - 1] == target {
                    start -= 1
                }
                while end + 1 < nums.count, nums[end + 1] == target {
                    end += 1
                }
                return [start, end]
            } else if nums[mid] > target {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return [-1, -1]
    }
    
    // MARK: - 540. 有序数组中的单一元素 (中等)
    /*
     给你一个仅由整数组成的有序数组，其中每个元素都会出现两次，唯有一个数只会出现一次。
     请你找出并返回只出现一次的那个数。
     你设计的解决方案必须满足 O(log n) 时间复杂度和 O(1) 空间复杂度。
     
     示例 1:
     输入: nums = [1,1,2,3,3,4,4,8,8]
     输出: 2
     1,2,2,3,3
     1,1,2,2,3
     0,1, 2, 3,4
     1, 3, 5, 7
     示例 2:
     输入: nums =  [3,3,7,7,10,11,11]
     输出: 10
     
     提示:
     1 <= nums.length <= 105
     0 <= nums[i] <= 105
     */
    static func singleNonDuplicate(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if ((right - left) / 2) % 2 == 0 {
                if mid > 1, nums[mid] == nums[mid - 1] {
                    right = mid - 2
                } else if mid < nums.count - 2, nums[mid] == nums[mid + 1]  {
                    left = mid + 2
                } else {
                    return nums[mid]
                }
            } else {
                if mid > 0, nums[mid] == nums[mid - 1] {
                    left = mid + 1
                } else if mid < nums.count - 1, nums[mid] == nums[mid + 1]  {
                    right = mid - 1
                } else {
                    return nums[mid]
                }
            }
        }
        return 0
    }
    
    // MARK: - 275.H 指数 II（中等）
    /*
     给你一个整数数组 citations ，其中 citations[i] 表示研究者的第 i 篇论文被引用的次数，citations 已经按照 升序排列 。计算并返回该研究者的 h 指数。
     h 指数的定义：h 代表“高引用次数”（high citations），一名科研人员的 h 指数是指他（她）的 （n 篇论文中）总共有 h 篇论文分别被引用了至少 h 次。且其余的 n - h 篇论文每篇被引用次数 不超过 h 次。
     
     提示：如果 h 有多种可能的值，h 指数 是其中最大的那个。
     请你设计并实现对数时间复杂度的算法解决此问题。
     
     示例 1：
     输入：citations = [0,1,3,5,6]
     输出：3
     解释：给定数组表示研究者总共有 5 篇论文，每篇论文相应的被引用了 0, 1, 3, 5, 6 次。
          由于研究者有 3 篇论文每篇 至少 被引用了 3 次，其余两篇论文每篇被引用 不多于 3 次，所以她的 h 指数是 3 。
     
     示例 2：
     输入：citations = [1,2,100]
     输出：2
     */
    static func hIndex(_ citations: [Int]) -> Int {
        let count = citations.count
        var left = 0
        var right = count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if citations[mid] == count - mid {
                return citations[mid]
            } else if citations[mid] < count - mid {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return count - left
    }
    // MARK: - 436. 寻找右区间（中等）
    /*
     给你一个区间数组 intervals ，其中 intervals[i] = [starti, endi] ，且每个 starti 都 不同 。
     区间 i 的 右侧区间 可以记作区间 j ，并满足 startj >= endi ，且 startj 最小化 。
     返回一个由每个区间 i 的 右侧区间 在 intervals 中对应下标组成的数组。如果某个区间 i 不存在对应的 右侧区间 ，则下标 i 处的值设为 -1 。
     
     示例 1：
     输入：intervals = [[1,2]]
     输出：[-1]
     解释：集合中只有一个区间，所以输出-1。
     
     示例 2：
     输入：intervals = [[3,4],[2,3],[1,2]]
     输出：[-1,0,1]
     解释：对于 [3,4] ，没有满足条件的“右侧”区间。
     对于 [2,3] ，区间[3,4]具有最小的“右”起点;
     对于 [1,2] ，区间[2,3]具有最小的“右”起点。
     
     示例 3：
     输入：intervals = [[1,4],[2,3],[3,4]]
     输出：[-1,2,-1]
     解释：对于区间 [1,4] 和 [3,4] ，没有满足条件的“右侧”区间。
     对于 [2,3] ，区间 [3,4] 有最小的“右”起点。
     */
    static func findRightInterval(_ intervals: [[Int]]) -> [Int] {
        // 暴力解法
        /*
        var result = [Int]()
        for i in 0..<intervals.count {
            let rangeI = intervals[i]
            var minIndex = -1
            var minStartValue = Int.max
            for j in 0..<intervals.count {
                let rangeJ = intervals[j]
                if rangeJ[0] >= rangeI[1], rangeJ[0] < minStartValue {
                    minIndex = j
                    minStartValue = rangeJ[0]
                }
            }
            result.append(minIndex)
        }
        return result
         */
        
        // 二分法
        var startIntervals = [[Int]]()
        for (index, interval) in intervals.enumerated() {
            startIntervals.append([interval[0], index])
        }
        startIntervals = startIntervals.sorted(by: { a, b in
            return a[0] < b[0]
        })
        print(startIntervals)
        var result = [Int]()
        for interval in intervals {
            var left = 0
            var right = startIntervals.count - 1
            while left <= right {
                let mid = left + (right - left) / 2
                if startIntervals[mid][0] >= interval[1] {
                    right = mid - 1
                } else if startIntervals[mid][0] < interval[1] {
                    left = mid + 1
                }
            }
            result.append(left < startIntervals.count ? startIntervals[left][1] : -1)
        }
        return result
    }
    
    // MARK: - 300. 最长递增子序列（中等）
    /*
     给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。
     子序列 是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的子序列。

     示例 1：
     输入：nums = [10,9,2,5,3,7,101,18]
     输出：4
     解释：最长递增子序列是 [2,3,7,101]，因此长度为 4 。
     
     示例 2：
     输入：nums = [0,1,0,3,2,3]
     输出：4
     
     示例 3：
     输入：nums = [7,7,7,7,7,7,7]
     输出：1
     */
    static func lengthOfLIS(_ nums: [Int]) -> Int {
        // 动态规划
        let n = nums.count
        if n == 0 { return 0 }
        // dp[i]代表以下标i结尾的最长递增子序列，初始化为1
        var dp = [Int](repeating: 1, count: n)
        var maxLength = 1
        // 从第二个元素开始
        for i in 1..<n {
            // 从下标0开始遍历小于下标i的元素
            for j in 0..<i {
                // 如果当前元素小于下标i位置的元素
                if nums[j] < nums[i]  {
                    // 以下标i结尾的最长递增子序列长度为：以下标j结尾的最长递增子序列长度+1，和之前的dp[i]比较取最大值
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
            maxLength = max(maxLength, dp[i])
        }
        return maxLength
    }
    
    // MARK: - 354. 俄罗斯套娃信封问题（困难）
    /*
     给你一个二维整数数组 envelopes ，其中 envelopes[i] = [wi, hi] ，表示第 i 个信封的宽度和高度。
     当另一个信封的宽度和高度都比这个信封大的时候，这个信封就可以放进另一个信封里，如同俄罗斯套娃一样。
     请计算 最多能有多少个 信封能组成一组“俄罗斯套娃”信封（即可以把一个信封放到另一个信封里面）。
     注意：不允许旋转信封。
     
     示例 1：
     输入：envelopes = [[5,4],[6,4],[6,7],[2,3]]
     输出：3
     解释：最多信封的个数为 3, 组合为: [2,3] => [5,4] => [6,7]。
     
     示例 2：
     输入：envelopes = [[1,1],[1,1],[1,1]]
     输出：1
     */
    static func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
        return 0
    }
    
    // MARK: - 658. 找到 K 个最接近的元素（中等）
    /*
     给定一个 排序好 的数组 arr ，两个整数 k 和 x ，从数组中找到最靠近 x（两数之差最小）的 k 个数。返回的结果必须要是按升序排好的。
     整数 a 比整数 b 更接近 x 需要满足：
     |a - x| < |b - x| 或者
     |a - x| == |b - x| 且 a < b
     
     示例 1：
     输入：arr = [1,2,3,4,5], k = 4, x = 3
     输出：[1,2,3,4]
     
     示例 2：
     输入：arr = [1,2,3,4,5], k = 4, x = -1
     输出：[1,2,3,4]
     */
    static func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        var left = 0
        var right = arr.count - k
        while left < right {
            let mid = left + (right - left) / 2
            if x - arr[mid] > arr[mid + k] - x {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return Array(arr[left..<left+k])
    }
    
    // MARK: - 162. 寻找峰值（中等）
    /*
     峰值元素是指其值严格大于左右相邻值的元素。
     给你一个整数数组 nums，找到峰值元素并返回其索引。数组可能包含多个峰值，在这种情况下，返回 任何一个峰值 所在位置即可。
     你可以假设 nums[-1] = nums[n] = -∞ 。
     你必须实现时间复杂度为 O(log n) 的算法来解决此问题。
     
     示例 1：
     输入：nums = [1,2,3,1]
     输出：2
     解释：3 是峰值元素，你的函数应该返回其索引 2。
     
     示例 2：
     输入：nums = [1,2,1,3,5,6,4]
     输出：1 或 5
     解释：你的函数可以返回索引 1，其峰值元素为 2；
          或者返回索引 5， 其峰值元素为 6。
      
     提示：
     1 <= nums.length <= 1000
     */
    static func findPeakElement(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        while left < right {
            let mid = left + (right - left) / 2
            if nums[mid] < nums[mid + 1] {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left
    }
    
    // MARK: - 4. 寻找两个正序数组的中位数（困难）
    /*
     给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。
     算法的时间复杂度应该为 O(log (m+n)) 。
     
     示例 1：
     输入：nums1 = [1,3], nums2 = [2]
     输出：2.00000
     解释：合并数组 = [1,2,3] ，中位数 2
     
     示例 2：
     输入：nums1 = [1,2], nums2 = [3,4]
     输出：2.50000
     解释：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5
     
     提示：
     nums1.length == m
     nums2.length == n
     0 <= m <= 1000
     0 <= n <= 1000
     1 <= m + n <= 2000
     -106 <= nums1[i], nums2[i] <= 106
     */
    static func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        return 0
    }
    
    // MARK: - 153. 寻找旋转排序数组中的最小值（中等）
    static func findMin(_ nums: [Int]) -> Int {
        let len = nums.count
        var left = 0
        var right = len - 1
        while left < right {
            let mid = left + (right - left) / 2
            if nums[mid] < nums[right] {
                right = mid
            } else {
                left = mid + 1
            }
        }
        return nums[left]
    }
    
    // MARK: - 154. 寻找旋转排序数组中的最小值 II（困难）
    static func findMin2(_ nums: [Int]) -> Int {
        let len = nums.count
        var left = 0
        var right = len - 1
        while left < right {
            let mid = left + (right - left) / 2
            if nums[mid] < nums[right] {
                right = mid
            } else if nums[mid] > nums[right] {
                left = mid + 1
            } else {
                right -= 1
            }
        }
        return nums[left]
    }
    
    // MARK: - 33. 搜索旋转排序数组
    static func search(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count
        var left = 0
        var right = count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target {
                return mid
            } else {
                if nums[mid] >= nums[0] {
                    if target >= nums[0] && target < nums[mid] {
                        right = mid - 1
                    } else {
                        left = mid + 1
                    }
                } else {
                    if target > nums[mid] && target <= nums[count - 1] {
                        left = mid + 1
                    } else {
                        right = mid - 1
                    }
                }
            }
        }
        return -1
    }
    
    // MARK: - 81. 搜索旋转排序数组 II
    static func search2(_ nums: [Int], _ target: Int) -> Bool {
        let count = nums.count
        var left = 0
        var right = count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] == target {
                return true
            } else {
                if nums[left] == nums[mid] && nums[right] == nums[mid] {
                    left += 1
                    right -= 1
                } else if nums[mid] >= nums[left] {
                    if target >= nums[left] && target < nums[mid] {
                        right = mid - 1
                    } else {
                        left = mid + 1
                    }
                } else if nums[mid] < nums[left] {
                    if target > nums[mid] && target <= nums[right] {
                        left = mid + 1
                    } else {
                        right = mid - 1
                    }
                }
            }
        }
        return false
    }
    
    // MARK: - 74. 搜索二维矩阵（中等）
    static func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let row = matrix.count
        let column = matrix[0].count
        var left = 0
        var right = row - 1
        var targetArr = [Int]()
        while left <= right {
            let mid = left + (right - left) / 2
            if target < matrix[mid][0] {
                right = mid - 1
            } else if target > matrix[mid][column - 1] {
                left = mid + 1
            } else {
                targetArr = matrix[mid]
                break
            }
        }
        guard !targetArr.isEmpty else { return false }
        left = 0
        right = column - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if target < targetArr[mid] {
                right = mid - 1
            } else if target > targetArr[mid] {
                left = mid + 1
            } else {
               return true
            }
        }
        return false
    }
    
    // MARK: - 240. 搜索二维矩阵 II（中等）
    static func searchMatrix2(_ matrix: [[Int]], _ target: Int) -> Bool {
        func binarySearch(_ nums: [Int], target: Int) -> Bool {
            var left = 0
            var right = nums.count - 1
            while left <= right {
                let mid = left + (right - left) / 2
                if target < nums[mid] {
                    right = mid - 1
                } else if target > nums[mid] {
                    left = mid + 1
                } else {
                    return true
                }
            }
            return false
        }
        
        for nums in matrix {
            if binarySearch(nums, target: target) {
                return true
            }
        }
        return false
    }
    
    // MARK: - 378. 有序矩阵中第 K 小的元素（中等）
//    static func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
//
//    }
    
    
    
}
