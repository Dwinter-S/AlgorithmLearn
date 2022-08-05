//
//  Array.swift
//  AlgorithmLearn
//
//  Created by 苏冬冬 on 2022/7/21.
//

import Foundation

class Array {
    // MARK: - 两数之和
    /*
     给定一个整数数组 nums 和一个整数目标，返回两个数字的索引，使它们加起来等于目标。
     您可能会假设每个输入都只有一个解决方案，并且您可能不会两次使用相同的元素。
     您可以按任何顺序返回答案。
     */
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        /// 暴力遍历
        /*
        let count = nums.count
        for i in 0..<count {
            for j in (i+1..<count) {
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }
        }
        return []
         */
        var map = [Int : Int]()
        for (i, num) in nums.enumerated() {
            if let j = map[target - num] {
                return [i, j]
            }
            map[num] = i
        }
        return []
    }
    
    // MARK: - 回文整数
    /*
     给定一个整数 x，如果 x 是回文整数，则返回 true。
     当一个整数向后读和向前读一样时，它就是一个回文数。
     例如，121 是回文，而 123 不是。
     */
    static func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else { return false }
        var num = x
        var nums = [Int]()
        while num > 0 {
            nums.append(num % 10)
            num /= 10
        }
        
        var i = 0, j = nums.count - 1
        while i < j {
            if nums[i] != nums[j] {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
    
    /*
     Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

     Symbol       Value
     I             1
     V             5
     X             10
     L             50
     C             100
     D             500
     M             1000
     */
    static func romanToInt(_ s: String) -> Int {
        let romanIntMap: [Character : Int] = ["I" : 1,
                                              "V" : 5,
                                              "X" : 10,
                                              "L" : 50,
                                              "C" : 100,
                                              "D" : 500,
                                              "M" : 1000]
        var index = s.startIndex
        var result = 0
        while index != s.endIndex {
            let str = s[index]
            let nextIndex = s.index(after: index)
            if nextIndex != s.endIndex {
                let nextStr = s[nextIndex]
                if str == "I" && (nextStr == "V" || nextStr == "X") {
                    result += romanIntMap[nextStr]! - 1
                    index = s.index(after: nextIndex)
                } else if str == "X" && (nextStr == "L" || nextStr == "C") {
                    result += romanIntMap[nextStr]! - 10
                    index = s.index(after: nextIndex)
                } else if str == "C" && (nextStr == "D" || nextStr == "M") {
                    result += romanIntMap[nextStr]! - 100
                    index = s.index(after: nextIndex)
                } else {
                    result += romanIntMap[str]!
                    index = nextIndex
                }
            } else {
                result += romanIntMap[str]!
                index = nextIndex
            }
        }
        return result
    }
    
    
    // MARK: - 最长公共子串
    static func longestCommonPrefix(_ strs: [String]) -> String {
        /*
        解法1：横向扫描
        guard strs.count > 1 else {
            return strs.first ?? ""
        }
        var result = ""
        let firstStr = strs[0]
        for i in 0..<firstStr.count {
            let c = firstStr.map { $0 }[i]
            for j in 1..<strs.count {
                let otherStrArr = strs[j].map { $0 }
                if i >= otherStrArr.count {
                    return result
                }
                if otherStrArr[i] != c {
                    return result
                }
            }
            result += String(c)
        }
        return result
         */
        
        /*
        解法2：纵向扫描
        let strCount = strs.count
        guard strCount > 1 else {
            return strs.first ?? ""
        }
        var result = strs[0]
        for i in 1..<strCount {
            while !strs[i].hasPrefix(result) {
                result = String(result[result.startIndex..<result.index(before: result.endIndex)])
                if result.isEmpty {
                    return ""
                }
            }
        }
        return result
         */
        
        /*
        解法3：分治法
         let strCount = strs.count
         guard strCount > 1 else {
             return strs.first ?? ""
         }
         return longestCommonPrefix(strs, left: 0, right: strs.count - 1)
         
         func longestCommonPrefix(_ strs: [String], left: Int, right: Int) -> String {
             if left == right {
                 return strs[left]
             }
             let mid = left + (right - left) / 2
             let leftResult = longestCommonPrefix(strs, left: left, right: mid)
             let rightResult = longestCommonPrefix(strs, left: mid + 1, right: right)
             return commonPrefix(leftResult, rightResult)
         }
         
         func commonPrefix(_ leftStr: String, _ rightStr: String) -> String {
             let minCount = min(leftStr.count, rightStr.count)
             let leftStrCharacters = leftStr.map { $0 }
             let rightStrCharacters = rightStr.map { $0 }
             for i in 0..<minCount {
                 if leftStrCharacters[i] != rightStrCharacters[i] {
                     return String(leftStr[leftStr.startIndex..<leftStr.index(leftStr.startIndex, offsetBy: i)])
                 }
             }
             return String(leftStr[leftStr.startIndex..<leftStr.index(leftStr.startIndex, offsetBy: minCount)])
         }
         */
        
        // 二分查找法
        let strCount = strs.count
        guard strCount > 1 else {
            return strs.first ?? ""
        }
        var minCount = Int.max
        for str in strs {
            minCount = min(minCount, str.count)
        }
        var low = 0
        var high = minCount
        while low <= high {
            let mid = low + (high - low) / 2
            if isCommonPrefix(strs, count: mid) {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        let str1 = strs[0]
        return String(str1[str1.startIndex..<strs[0].index(str1.startIndex, offsetBy: (low + high) / 2)])
        
        func isCommonPrefix(_ strs: [String], count: Int) -> Bool {
            let str = strs[0]
            let str1 = str[str.startIndex..<str.index(str.startIndex, offsetBy: count)]
            for i in 1..<strs.count {
                if !strs[i].hasPrefix(str1) {
                    return false
                }
            }
            return true
        }
        
    }
    
    // MARK: - 有效括号
    /*
     给定一个s仅包含字符'('、')'、'{'、和的字符串'}'，确定输入字符串是否有效。'['']'
     输入字符串在以下情况下有效：
     开括号必须用相同类型的括号闭合。
     开括号必须以正确的顺序闭合。
     */
    static func isValid(_ s: String) -> Bool {
        guard s.count % 2 == 0 else { return false }
        var stack = [Character]()
        var i = 0
        let chars = s.map { $0 }
        while i < s.count {
            let c = chars[i]
            if c == "(" || c == "[" || c == "{" {
                stack.append(c)
            } else {
                if let preLeft = stack.popLast() {
                    if (preLeft == "(" && c == ")") || (preLeft == "[" && c == "]") || (preLeft == "{" && c == "}") {
                        i += 1
                        continue
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
            i += 1
        }
        return stack.isEmpty
        
//        func findLeft(right: Character) -> Character {
//            if right == ")" {
//                return "("
//            } else if right == "]" {
//                return "["
//            }
//            return "{"
//        }
    }
    
    // MARK: - 从排序数组中删除重复项
//    [1, 1, 2]
    static func removeDuplicates(_ nums: inout [Int]) -> Int {
        var slow = 0
        var fast = 1
        let count = nums.count
        while fast < count {
            if nums[fast] != nums[slow] {
                nums[slow + 1] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        return slow
    }
    
    // MARK: - 移除元素（可以改变元素位置）
    static func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        /*
        解法1：
        var j = 0
        for num in nums {
            if num != val {
                nums[j] = num
                j += 1
            }
        }
        return j
         */
        
        // 解法2
        var i = 0
        var j = nums.count - 1
        while i <= j {
            if nums[i] == val {
                nums[i] = nums[j]
                j -= 1
            } else {
                i += 1
            }
        }
        return i
    }
    
    // MARK: - 实现 strStr()
    static func  strStr(_ haystack: String, _ needle: String) -> Int {
        let haystackCount = haystack.count
        let needleCount = needle.count
        guard haystackCount >= needleCount else { return -1 }
        for i in 0...(haystackCount - needleCount) {
            let str = String(haystack[haystack.index(haystack.startIndex, offsetBy: i)..<haystack.index(haystack.startIndex, offsetBy: i + needleCount)])
            if str == needle {
                return i
            }
        }
        return -1
    }
    
    // MARK: - 搜索插入位置
    /*
     给定一个由不同整数组成的排序数组和一个目标值，如果找到目标，则返回索引。如果不是，则返回按顺序插入的索引。
     您必须编写具有 O(log n)运行时复杂性的算法。
     */
    static func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var low = 0
        var high = nums.count - 1
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid] == target {
                return mid
            } else if nums[mid] > target {
                high = mid - 1
            } else if nums[mid] < target {
                low = mid + 1
            }
        }
        return low
    }
    
    // MARK: - 最后一个单词的长度
    /*
     给定一个s由单词和空格组成的字符串，返回字符串中最后一个单词的长度。
     单词是仅由非空格字符组成的最大子串。
     */
    static func lengthOfLastWord(_ s: String) -> Int {
        let chars = s.map { $0 }
        let count = chars.count
        var i = count - 1
        while i >= 0 {
            if chars[i] != " " {
                break
            }
            i -= 1
        }
        var res = 0
        while i >= 0 {
            if chars[i] == " " {
                break
            }
            i -= 1
            res += 1
        }
        return res
    }
    
    // MARK: - 加一
    /*
     你得到一个表示为整数数组的大整数digits，其中每个digits[i]都是整数的数字。数字按从左到右的顺序从最高有效到最低有效排序。大整数不包含任何前导的。ith0
     将大整数加 1 并返回结果数组。
     */
    static func plusOne(_ digits: [Int]) -> [Int] {
        var newDigits = digits
        var i = digits.count - 1
        var increment = 1
        while i >= 0 {
            let digit = digits[i]
            let resultDigit = digit + increment
            if resultDigit >= 10 {
                increment = 1
                newDigits[i] = 0
            } else {
                increment = 0
                newDigits[i] = resultDigit
                break
            }
            i -= 1
        }
        if increment == 1 {
            newDigits.insert(1, at: 0)
        }
        return newDigits
    }
    
    // MARK: - 添加二进制
    /*
     给定两个二进制字符串a和b，将它们的总和作为二进制字符串返回。
     */
    static func addBinary(_ a: String, _ b: String) -> String {
        let aChars = a.map { $0 }
        let bChars = b.map { $0 }
        var i = aChars.count - 1
        var j = bChars.count - 1
        var increment = 0
        var res = [Character]()
        while i >= 0 || j >= 0 {
            var aNum = 0
            if i >= 0 {
                aNum = Int(String(aChars[i]))!
            }
            var bNum = 0
            if j >= 0 {
                bNum = Int(String(bChars[j]))!
            }
            let sum = aNum + bNum + increment
            if sum >= 2 {
                increment = 1
            } else {
                increment = 0
            }
            res.insert(Character("\(sum % 2)"), at: 0)
            i -= 1
            j -= 1
        }
        
        if increment == 1 {
            res.insert("1", at: 0)
        }
        
        return String(res)
    }
    
    // MARK: - Sqrt(x)
    /*
     给定一个非负整数x，计算并返回的平方根 x。
     由于返回类型是整数，所以十进制数字被截断，只返回结果的整数部分。
     注意： 您不能使用任何内置的指数函数或运算符，例如pow(x, 0.5)or  x ** 0.5。
     */
    static func mySqrt(_ x: Int) -> Int {
        if x == 0 { return 0 }
        if x == 1 { return 1 }
        var high = x
        var low = 0
        while low <= high  {
            let mid = low + (high - low) / 2
            let num = mid * mid
            if num == x {
                return mid
            } else if num > x {
                high = mid - 1
            } else if num < x {
                low = mid + 1
            }
        }
        return high
    }
    // MARK: - 最大连续1的个数
    /*
     给定一个二进制数组 nums ， 计算其中最大连续 1 的个数。
     示例 1：
     输入：nums = [1,1,0,1,1,1]
     输出：3
     解释：开头的两位和最后的三位都是连续 1 ，所以最大连续 1 的个数是 3.
     示例 2:
     输入：nums = [1,0,1,1,0,1]
     输出：2
     */
    static func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var maxCount = 0
        var currentCount = 0
        for num in nums {
            if num == 1 {
                currentCount += 1
            } else {
                maxCount = max(maxCount, currentCount)
                currentCount = 0
            }
        }
        maxCount = max(maxCount, currentCount)
        return maxCount
    }
    
    // MARK: - 提莫攻击
    /*
     给你一个 非递减 的整数数组 timeSeries ，其中 timeSeries[i] 表示提莫在 timeSeries[i] 秒时对艾希发起攻击，以及一个表示中毒持续时间的整数 duration。
     返回艾希处于中毒状态的 总 秒数。
     */
    static func findPoisonedDuration(_ timeSeries: [Int], _ duration: Int) -> Int {
        var totalDuration = 0
        let count = timeSeries.count
        for i in 0..<count {
            let curTime = timeSeries[i]
            if i + 1 < count {
                let nextTime = timeSeries[i + 1]
                if nextTime - curTime < duration {
                    totalDuration += nextTime - curTime
                } else {
                    totalDuration += duration
                }
            } else {
                totalDuration += duration
            }
        }
        return totalDuration
    }
    
    // MARK: - 第三大的数
    /*
     给你一个非空数组，返回此数组中 第三大的数 。如果不存在，则返回数组中最大的数。
     示例 1：
     输入：[3, 2, 1]
     输出：1
     解释：第三大的数是 1 。
     
     示例 2：
     输入：[1, 2]
     输出：2
     解释：第三大的数不存在, 所以返回最大的数 2 。
     
     示例 3：
     输入：[2, 2, 3, 1]
     输出：1
     解释：注意，要求返回第三大的数，是指在所有不同数字中排第三大的数。
     此例中存在两个值为 2 的数，它们都排第二。在所有不同数字中排第三大的数为 1 。
     */
    static func thirdMax(_ nums: [Int]) -> Int {
        var max = Int.min
        var secondMax = Int.min
        var thirdMax = Int.min
        for num in nums {
            if num > max {
                thirdMax = secondMax
                secondMax = max
                max = num
            } else if num > secondMax && num < max {
                thirdMax = secondMax
                secondMax = num
            } else if num > thirdMax  && num < secondMax {
                thirdMax = num
            }
        }
        if thirdMax == Int.min {
            return max
        }
        return thirdMax
    }
    // MARK: - 三个数组成的最大乘积
    /*
     给你一个整型数组 nums ，在数组中找出由三个数组成的最大乘积，并输出这个乘积。
     示例 1：
     输入：nums = [1,2,3]
     输出：6
     
     示例 2：
     输入：nums = [1,2,3,4]
     输出：24
     
     示例 3：
     输入：nums = [-1,-2,-3]
     输出：-6
     */
    static func maximumProduct(_ nums: [Int]) -> Int {
        let sortedNums = nums.sorted(by: >)
        let count = sortedNums.count
        let result1 = sortedNums[0] * sortedNums[1] * sortedNums[2]
        let result2 = sortedNums[count - 2] * sortedNums[count - 1] * sortedNums[0]
        return max(result1, result2)
    }
    
    // MARK: - 错误的集合
    /*
     集合 s 包含从 1 到 n 的整数。不幸的是，因为数据错误，导致集合里面某一个数字复制了成了集合里面的另外一个数字的值，导致集合 丢失了一个数字 并且 有一个数字重复 。
     给定一个数组 nums 代表了集合 S 发生错误后的结果。
     请你找出重复出现的整数，再找到丢失的整数，将它们以数组的形式返回。
     示例 1：
     输入：nums = [1,2,2,4]
     输出：[2,3]
     
     示例 2：
     输入：nums = [1,1]
     输出：[1,2]
     */
    static func findErrorNums(_ nums: [Int]) -> [Int] {
        var lostNum: Int
        var repeatedNum: Int = 0
        var numCountMap = [Int : Int]()
        var rightTotal = 0
        var wrongTotal = 0
        for i in 0..<nums.count {
            rightTotal += i + 1
            wrongTotal += nums[i]
            if numCountMap[nums[i]] == 1 {
                repeatedNum = nums[i]
            } else {
                numCountMap[nums[i]] = 1
            }
        }
        lostNum = repeatedNum + rightTotal - wrongTotal
        return [repeatedNum, lostNum]
    }
    
    // MARK: - 数组的度
    /*
     给定一个非空且只包含非负数的整数数组 nums，数组的 度 的定义是指数组里任一元素出现频数的最大值。
     你的任务是在 nums 中找到与 nums 拥有相同大小的度的最短连续子数组，返回其长度。
     示例 1：
     输入：nums = [1,2,2,3,1]
     输出：2
     解释：
     输入数组的度是 2 ，因为元素 1 和 2 的出现频数最大，均为 2 。
     连续子数组里面拥有相同度的有如下所示：
     [1, 2, 2, 3, 1], [1, 2, 2, 3], [2, 2, 3, 1], [1, 2, 2], [2, 2, 3], [2, 2]
     最短连续子数组 [2, 2] 的长度为 2 ，所以返回 2 。
     
     示例 2：
     输入：nums = [1,2,2,3,1,4,2]
     输出：6
     解释：
     数组的度是 3 ，因为元素 2 重复出现 3 次。
     所以 [2,2,3,1,4,2] 是最短子数组，因此返回 6 。
     */
    static func findShortestSubArray(_ nums: [Int]) -> Int {
        var map = [Int : [Int]]()
        for (index, num) in nums.enumerated() {
            if let arr = map[num] {
                map[num] = [arr[0] + 1, arr[1], index]
            } else {
                map[num] = [1, index, index]
            }
        }
        
        var shortestLength = Int.max
        var maxCount = 0
        for arr in map.values {
            let numCount = arr[0]
            let numStartIndex = arr[1]
            let numEndIndex = arr[2]
            if numCount > maxCount {
                maxCount = numCount
                shortestLength = numEndIndex - numStartIndex + 1
            } else if numCount == maxCount {
                shortestLength = min(shortestLength, numEndIndex - numStartIndex + 1)
            }
        }
        return shortestLength
    }
    
    // MARK: - 找到所有数组中消失的数字
    /*
     给你一个含 n 个整数的数组 nums ，其中 nums[i] 在区间 [1, n] 内。请你找出所有在 [1, n] 范围内但没有出现在 nums 中的数字，并以数组的形式返回结果。
     示例 1：
     输入：nums = [4,3,2,7,8,2,3,1]
     输出：[5,6]
     
     示例 2：
     输入：nums = [1,1]
     输出：[2]
     */
    static func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        /*
        var map = [Int : Int]()
        for i in 1...nums.count {
            map[i] = 0
        }
        for num in nums {
            let count = map[num] ?? 0
            map[num] = count + 1
        }
        var result = [Int]()
        for (num, count) in map {
            if count == 0 {
                result.append(num)
            }
        }
        return result
         */
        // 不用额外空间
        var nums = nums
        let count = nums.count
        for i in 0..<count {
            let x = (nums[i] - 1) % count
            nums[x] += count
        }
        var result = [Int]()
        for i in 0..<count {
            if nums[i] <= count {
                result.append(i + 1)
            }
        }
        return result
    }
    
    // MARK: - 数组中重复的数据(中等)
    /*
     给你一个长度为 n 的整数数组 nums ，其中 nums 的所有整数都在范围 [1, n] 内，且每个整数出现 一次 或 两次 。请你找出所有出现 两次 的整数，并以数组形式返回。
     你必须设计并实现一个时间复杂度为 O(n) 且仅使用常量额外空间的算法解决此问题。
     示例 1：
     输入：nums = [4,3,2,7,8,2,3,1]
     输出：[2,3]
     
     示例 2：
     输入：nums = [1,1,2]
     输出：[1]
     
     示例 3：
     输入：nums = [1]
     输出：[]
     */
    static func findDuplicates(_ nums: [Int]) -> [Int] {
        /*
         // 交换
        var nums = nums
        var result = [Int]()
        for i in 0..<nums.count {
            while nums[i] != nums[nums[i] - 1] {
                (nums[i], nums[nums[i] - 1]) = (nums[nums[i] - 1], nums[i])
            }
        }
        for i in 0..<nums.count {
            if nums[i] != i + 1 {
                result.append(nums[i])
            }
        }
        return result
         */
        
        // 赋值为负数
        var nums = nums
        var result = [Int]()
        for i in 0..<nums.count {
            let x = abs(nums[i])
            if nums[x - 1] > 0 {
                nums[x - 1] = -nums[x - 1]
            } else {
                result.append(x)
            }
        }
        return result
    }
    
    // MARK: - 41. 缺失的第一个正数 (困难)
    /*
     给你一个未排序的整数数组 nums ，请你找出其中没有出现的最小的正整数。
     请你实现时间复杂度为 O(n) 并且只使用常数级别额外空间的解决方案。
     示例 1：
     输入：nums = [1,2,0]
     输出：3
     
     示例 2：
     输入：nums = [3,4,-1,1]
     输出：2
     
     示例 3：
     输入：nums = [7,8,9,11,12]
     输出：1
     */
    static func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums
        let count = nums.count
        for i in 0..<count {
            while nums[i] > 0, nums[i] < count, nums[i] != nums[nums[i] - 1] {
                (nums[nums[i] - 1], nums[i]) = (nums[i], nums[nums[i] - 1])
            }
        }
        var result = 1
        for i in 0..<count {
            if nums[i] != i + 1 {
                return i + 1
            } else {
                result += 1
            }
        }
        return result
    }
    
    // MARK: - 274. H 指数 (中等)
    /*
     给你一个整数数组 citations ，其中 citations[i] 表示研究者的第 i 篇论文被引用的次数。计算并返回该研究者的 h 指数。
     根据维基百科上 h 指数的定义：h 代表“高引用次数”，一名科研人员的 h指数是指他（她）的 （n 篇论文中）总共有 h 篇论文分别被引用了至少 h 次。且其余的 n - h 篇论文每篇被引用次数 不超过 h 次。
     如果 h 有多种可能的值，h 指数 是其中最大的那个。
     示例 1：
     输入：citations = [3,0,6,1,5]
     输出：3
     解释：给定数组表示研究者总共有 5 篇论文，每篇论文相应的被引用了 3, 0, 6, 1, 5 次。
          由于研究者有 3 篇论文每篇 至少 被引用了 3 次，其余两篇论文每篇被引用 不多于 3 次，所以她的 h 指数是 3。
     
     示例 2：
     输入：citations = [1,3,1]
     输出：1
     */
    static func hIndex(_ citations: [Int]) -> Int {
        /*
         // 直接排序
        let sortedCitations = citations.sorted()
        var i = sortedCitations.count - 1
        var hIndex = 0
        while i >= 0 {
            if sortedCitations[i] > hIndex {
                hIndex += 1
            }
            i -= 1
        }
        return hIndex
         */
        
        // 计数排序
        let count = citations.count
        var counter = [Int](repeating: 0, count: count + 1)
        for citation in citations {
            if citation >= count {
                counter[count] += 1
            } else {
                counter[citation] += 1
            }
        }
        print(counter)
        var total = 0
        for i in (0..<counter.count).reversed() {
            total += counter[i]
            if total >= i {
                return i
            }
        }
        return 0
    }
    
    // MARK: - 453. 最小操作次数使数组元素相等 (中等)
    /*
     给你一个长度为 n 的整数数组，每次操作将会使 n - 1 个元素增加 1 。返回让数组所有元素相等的最小操作次数。
     示例 1：
     输入：nums = [1,2,3]
     输出：3
     解释：
     只需要3次操作（注意每次操作会增加两个元素的值）：
     [1,2,3]  =>  [2,3,3]  =>  [3,4,3]  =>  [4,4,4]
     
     示例 2：
     输入：nums = [1,1,1]
     输出：0
     */
    static func minMoves(_ nums: [Int]) -> Int {
        let minNum = nums.min() ?? 0
        var result = 0
        for num in nums {
            result += num - minNum
        }
        return result
    }
    
    // MARK: - 665. 非递减数列 (中等)
    /*
     给你一个长度为 n 的整数数组 nums ，请你判断在 最多 改变 1 个元素的情况下，该数组能否变成一个非递减数列。
     我们是这样定义一个非递减数列的： 对于数组中任意的 i (0 <= i <= n-2)，总满足 nums[i] <= nums[i + 1]。
     示例 1:
     输入: nums = [4,2,3]
     输出: true
     解释: 你可以通过把第一个 4 变成 1 来使得它成为一个非递减数列。
     1525
     示例 2:
     输入: nums = [4,2,1]
     输出: false
     解释: 你不能在只改变一个元素的情况下将其变为非递减数列。
     */
    static func checkPossibility(_ nums: [Int]) -> Bool {
        var nums = nums
        let count = nums.count
        var replaceTimes = 0
        for i in 0..<count - 1 {
            let x = nums[i]
            let y = nums[i + 1]
            if y < x {
                replaceTimes += 1
                if replaceTimes > 1 {
                    return false
                }
                if i > 0, nums[i - 1] > y {
                    nums[i + 1] = x
                }
            }
        }
        return true
    }
    
    // MARK: - 283. 移动零
    /*
     给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
     请注意 ，必须在不复制数组的情况下原地对数组进行操作。
     示例 1:
     输入: nums = [0,1,0,3,12]
     输出: [1,3,12,0,0]
     [1, 2, 0, 3, 4]
     示例 2:
     输入: nums = [0]
     输出: [0]
     */
    static func moveZeros(_ nums: inout [Int]) {
        var left = 0
        var right = 0
        while right < nums.count {
            if nums[right] != 0 {
                (nums[left], nums[right]) = (nums[right], nums[left])
                left += 1
            }
            right += 1
        }
    }
    
    // MARK: - 118.杨辉三角
    /*
     给定一个非负整数 numRows，生成「杨辉三角」的前 numRows 行。
     在「杨辉三角」中，每个数是它左上方和右上方的数的和。
     示例 1:
     输入: numRows = 5
     输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
     
     示例 2:
     输入: numRows = 1
     输出: [[1]]
     */
    static func generate(_ numRows: Int) -> [[Int]] {
        let firstRow = [1]
        let secondRow = [1, 1]
        if numRows == 0 {
            return []
        }
        if numRows == 1 {
            return [firstRow]
        }
        if numRows == 2 {
            return [firstRow, secondRow]
        }
        var result = [firstRow, secondRow]
        for i in 2..<numRows {
            let lastRow = result.last!
            var thisRow = [Int]()
            thisRow.append(1)
            for j in 1..<i {
                thisRow.append(lastRow[j] + lastRow[j - 1])
            }
            thisRow.append(1)
            result.append(thisRow)
        }
        return result
    }
    
    // MARK: - 119.杨辉三角
    /*
     给定一个非负索引 rowIndex，返回「杨辉三角」的第 rowIndex 行。
     在「杨辉三角」中，每个数是它左上方和右上方的数的和。
     示例 1:
     输入: rowIndex = 3
     输出: [1,3,3,1]
     
     示例 2:
     输入: rowIndex = 0
     输出: [1]
     */
    static func getRow(_ rowIndex: Int) -> [Int] {
        guard rowIndex > 0 else { return [] }
        return generate(rowIndex)[rowIndex - 1]
    }
    
}
