//
//  TwoPointers.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class TwoPointers {
    
    // MARK: - 345. 反转字符串中的元音字母
    /*
     给你一个字符串 s ，仅反转字符串中的所有元音字母，并返回结果字符串。
     元音字母包括 'a'、'e'、'i'、'o'、'u'，且可能以大小写两种形式出现。
     
     示例 1：
     输入：s = "hello"
     
     输出："holle"
     示例 2：
     输入：s = "leetcode"
     输出："leotcede"
     
     提示：
     1 <= s.length <= 3 * 105
     s 由 可打印的 ASCII 字符组成
     */
    static func reverseVowels(_ s: String) -> String {
        var chars = Array(s)
        var left = 0
        var right = chars.count - 1
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        while left < right {
            while !vowels.contains(chars[left]), left < right {
                left += 1
            }
            while !vowels.contains(chars[right]), left < right {
                right -= 1
            }
            (chars[left], chars[right]) = (chars[right], chars[left])
            left += 1
            right -= 1
        }
        return String(chars)
    }
    
    // MARK: - 680. 验证回文字符串 Ⅱ
    /*
     给定一个非空字符串 s，最多删除一个字符。判断是否能成为回文字符串。
     
     示例 1:
     输入: s = "aba"
     输出: true
     
     示例 2:
     输入: s = "abca"
     输出: true
     解释: 你可以删除c字符。
     
     示例 3:
     输入: s = "abc"
     输出: false
     
     提示:
     1 <= s.length <= 105
     s 由小写英文字母组成
     */
    static func validPalindrome(_ s: String) -> Bool {
        func validPalindrome(_ chars: [Character], left: Int, right: Int) -> Bool {
            let chars = chars
            var left = left
            var right = right
            while left < right {
                if chars[left] != chars[right] {
                    return false
                }
                left += 1
                right -= 1
            }
            return true
        }
        let chars = Array(s)
        var left = 0
        var right = chars.count - 1
        while left < right {
            if chars[left] != chars[right] {
                return validPalindrome(chars, left: left + 1, right: right) || validPalindrome(chars, left: left, right: right - 1)
            }
            left += 1
            right -= 1
        }
        return true
    }
    
    // MARK: - 167. 两数之和 II - 输入有序数组
    /*
     给你一个下标从 1 开始的整数数组 numbers ，该数组已按 非递减顺序排列  ，请你从数组中找出满足相加之和等于目标数 target 的两个数。如果设这两个数分别是 numbers[index1] 和 numbers[index2] ，则 1 <= index1 < index2 <= numbers.length 。
     以长度为 2 的整数数组 [index1, index2] 的形式返回这两个整数的下标 index1 和 index2。
     你可以假设每个输入 只对应唯一的答案 ，而且你 不可以 重复使用相同的元素。
     你所设计的解决方案必须只使用常量级的额外空间。

     示例 1：
     输入：numbers = [2,7,11,15], target = 9
     输出：[1,2]
     解释：2 与 7 之和等于目标数 9 。因此 index1 = 1, index2 = 2 。返回 [1, 2] 。
     
     示例 2：
     输入：numbers = [2,3,4], target = 6
     输出：[1,3]
     解释：2 与 4 之和等于目标数 6 。因此 index1 = 1, index2 = 3 。返回 [1, 3] 。
     
     示例 3：
     输入：numbers = [-1,0], target = -1
     输出：[1,2]
     解释：-1 与 0 之和等于目标数 -1 。因此 index1 = 1, index2 = 2 。返回 [1, 2] 。
     
     提示：
     2 <= numbers.length <= 3 * 104
     -1000 <= numbers[i] <= 1000
     numbers 按 非递减顺序 排列
     -1000 <= target <= 1000
     仅存在一个有效答案
     */
    static func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1
        while left < right {
            if numbers[left] + numbers[right] == target {
                return [left + 1, right + 1]
            } else if numbers[left] + numbers[right] < target {
                left += 1
            } else {
                right -= 1
            }
        }
        return [-1, -1]
    }
    
    // MARK: - 15. 三数之和 (中等)
    /*
     给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。
     注意：答案中不可以包含重复的三元组。
     
     示例 1：
     输入：nums = [-1,0,1,2,-1,-4]
     输出：[[-1,-1,2],[-1,0,1]]
     
     示例 2：
     输入：nums = []
     输出：[]
     
     示例 3：
     输入：nums = [0]
     输出：[]
     
     提示：
     0 <= nums.length <= 3000
     -105 <= nums[i] <= 105
     */
    static func threeSum(_ nums: [Int]) -> [[Int]] {
        let sortedNums = nums.sorted()
        let count = sortedNums.count
        var result = [[Int]]()
        for i in 0..<count {
            if i > 0, sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            let firstNum = sortedNums[i]
            let targetNum = -firstNum
            for j in (i + 1)..<count {
                if j > i + 1, sortedNums[j] == sortedNums[j - 1] {
                    continue
                }
                let left = j
                var right = count - 1
                while left < right, sortedNums[left] + sortedNums[right] > targetNum {
                    right -= 1
                }
                if left == right {
                    break
                }
                if sortedNums[left] + sortedNums[right] == targetNum {
                    result.append([firstNum, sortedNums[left], sortedNums[right]])
                }
            }
        }
        return result
    }
    
    // MARK: - 16. 最接近的三数之和 (中等)
    /*
     给你一个长度为 n 的整数数组 nums 和 一个目标值 target。请你从 nums 中选出三个整数，使它们的和与 target 最接近。
     返回这三个数的和。
     假定每组输入只存在恰好一个解。
     
     示例 1：
     输入：nums = [-1,2,1,-4], target = 1
     输出：2
     解释：与 target 最接近的和是 2 (-1 + 2 + 1 = 2) 。
     
     示例 2：
     输入：nums = [0,0,0], target = 1
     输出：0
     
     提示：
     3 <= nums.length <= 1000
     -1000 <= nums[i] <= 1000
     -104 <= target <= 104
     */
    static func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let sortedNums = nums.sorted()
        let count = sortedNums.count
        var diff = Int.max
        var result = 0
        for i in 0..<count {
            if i > 0, sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            let firstNum = sortedNums[i]
            var left = i + 1
            var right = count - 1
            while left < right {
                let sum = firstNum + sortedNums[left] + sortedNums[right]
                if sum == target {
                    return target
                }
                if abs(target - sum) < diff {
                    diff = abs(target - sum)
                    result = sum
                }
                if sum > target {
                    right -= 1
                } else {
                    left += 1
                }
            }
        }
        return result
    }
    
    // MARK: - 18. 四数之和（中等）
    /*
     给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回满足下述全部条件且不重复的四元组 [nums[a], nums[b], nums[c], nums[d]] （若两个四元组元素一一对应，则认为两个四元组重复）：

     0 <= a, b, c, d < n
     a、b、c 和 d 互不相同
     nums[a] + nums[b] + nums[c] + nums[d] == target
     你可以按 任意顺序 返回答案 。
     
     示例 1：
     输入：nums = [1,0,-1,0,-2,2], target = 0
     输出：[[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
     
     示例 2：
     输入：nums = [2,2,2,2,2], target = 8
     输出：[[2,2,2,2]]
     */
    static func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        return []
    }
    
    // MAKR: - 11. 盛最多水的容器（中等）
    static func maxArea(_ height: [Int]) -> Int {
        var left = 0
        var right = height.count - 1
        var maxValue = 0
        while left < right {
            let curValue = (right - left) * min(height[left], height[right])
            maxValue = max(curValue, maxValue)
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        return maxValue
    }
    
    // MAKR: - 42. 接雨水（困难 ）
    static func trap(_ height: [Int]) -> Int {
        var ans = 0
        var left = 0
        var right = height.count - 1
        var leftMax = 0
        var rightMax = 0
        while left < right {
            leftMax = max(leftMax, height[left])
            rightMax = max(rightMax, height[right])
            if height[left] < height[right] {
                ans += leftMax - height[left]
                left += 1
            } else {
                ans += rightMax - height[right]
                right -= 1
            }
        }
        return ans
    }
    
    // MARK: - 27. 移除元素
    static func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            if nums[left] == val {
                nums[left] = nums[right]
                right -= 1
            } else {
                left += 1
            }
            print("\(nums) \(left) \(right)")
        }
        return left
    }
    
    // MARK: - 26. 删除有序数组中的重复项
    static func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 1 else { return nums.count }
        var slow = 0
        var fast = 1
        while fast < nums.count {
            if nums[slow] != nums[fast] {
                nums[slow + 1] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        return slow + 1
    }
    
    // MARK: - 80. 删除有序数组中的重复项 II（中等）
    static func removeDuplicates2(_ nums: inout [Int]) -> Int {
        /*
        guard nums.count > 1 else { return nums.count }
        var slow = 0
        var fast = 1
        var repeatCount = 1
        while fast < nums.count {
            if nums[slow] != nums[fast] {
                nums[slow + 1] = nums[fast]
                slow += 1
                repeatCount = 1
            } else {
                if repeatCount == 1 {
                    nums[slow + 1] = nums[fast]
                    slow += 1
                }
                repeatCount += 1
            }
            fast += 1
            print("\(nums)")
        }
        return slow + 1
         */
        let count = nums.count
        guard count > 2 else { return count }
        // slow代表删除后数组的长度
        var slow = 2
        var fast = 2
        while fast < count {
            // 至多两个元素重复，慢指针最后一个元素下标slow-1
            // 如果nums[slow - 2] == nums[fast]，则至少有三个元素重复（slow-1、slow-2、fast）,否则至多两个元素重复（slow-1、slow-2），nums[fast]赋值给nums[slow]
            if nums[slow - 2] != nums[fast] {
                nums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        return slow
    }
    
    // MARK: - 83. 删除排序链表中的重复元素
    static func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var cur = head
        while cur != nil {
            while cur?.val == cur?.next?.val {
                cur?.next = cur?.next?.next
            }
            cur = cur?.next
        }
        return head
    }
    
    // MARK: - 82. 删除排序链表中的重复元素 II（中等）
    static func deleteDuplicate2(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode()
        dummy.next = head
        var cur = head
        var pre: ListNode? = dummy
        while cur != nil {
            if cur?.val != cur?.next?.val {
                pre = pre?.next
            } else {
                while cur?.val == cur?.next?.val {
                    cur?.next = cur?.next?.next
                }
                pre?.next = cur?.next
            }
            cur = cur?.next
        }
        return dummy.next
    }
    
    // MARK: - 611. 有效三角形的个数（中等）
    static func triangleNumber(_ nums: [Int]) -> Int {
        let count = nums.count
        guard count >= 3 else { return 0 }
        let sortedNums = nums.sorted()
        var ans = 0
        for i in 0..<count-2 {
            for j in i+1..<count {
                var right = count - 1
                while j < right {
                    if sortedNums[i] + sortedNums[j] <= sortedNums[right] {
                        right -= 1
                    } else {
                        ans += right - j
                        break
                    }
                }
            }
        }
        return ans
    }
}
