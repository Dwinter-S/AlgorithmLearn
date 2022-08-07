//
//  String.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class AlString {
    // MARK: - 520. 检测大写字母
    /*
     我们定义，在以下情况时，单词的大写用法是正确的：
     全部字母都是大写，比如 "USA" 。
     单词中所有字母都不是大写，比如 "leetcode" 。
     如果单词不只含有一个字母，只有首字母大写， 比如 "Google" 。
     给你一个字符串 word 。如果大写用法正确，返回 true ；否则，返回 false 。
     示例 1：
     输入：word = "USA"
     输出：true
     
     示例 2：
     输入：word = "FlaG"
     输出：false
     
     提示：
     1 <= word.length <= 100
     word 由小写和大写英文字母组成
     */
    static func detectCapitalUse(_ word: String) -> Bool {
        let chars = word.map { $0 }
        let firstCharIsCapital = chars[0].isUppercase
        var capitalCount = firstCharIsCapital ? 1 : 0
        for i in 1..<chars.count {
            if firstCharIsCapital {
                if chars[i].isUppercase {
                    capitalCount += 1
                }
            } else {
                if chars[i].isUppercase {
                    return false
                }
            }
        }
        return capitalCount == 0 || capitalCount == 1 || capitalCount == chars.count
    }
    
    // MARK: - 125. 验证回文串
    /*
     给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
     说明：本题中，我们将空字符串定义为有效的回文串。
     示例 1:
     输入: "A man, a plan, a canal: Panama"
     输出: true
     解释："amanaplanacanalpanama" 是回文串
     
     示例 2:
     输入: "race a car"
     输出: false
     解释："raceacar" 不是回文串
     
     提示：
     1 <= s.length <= 2 * 105
     字符串 s 由 ASCII 字符组成
     */
    static func isPalindrome(_ s: String) -> Bool {
        if s.isEmpty { return true }
        let chars = s.filter{ $0.isNumber || $0.isLetter }.lowercased().map { $0 }
        var i = 0
        var j = chars.count - 1
        while i < j {
            if chars[i] != chars[j] {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
    
    // MARK: - 14.最长公共前缀
    /*
     编写一个函数来查找字符串数组中的最长公共前缀。
     如果不存在公共前缀，返回空字符串 ""。
     示例 1：
     输入：strs = ["flower","flow","flight"]
     输出："fl"
     
     示例 2：
     输入：strs = ["dog","racecar","car"]
     输出：""
     解释：输入不存在公共前缀。
     
     提示：
     1 <= strs.length <= 200
     0 <= strs[i].length <= 200
     strs[i] 仅由小写英文字母组成
     */
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
    }
    
    // MARK: - 434.字符串中的单词数
    /*
     统计字符串中的单词个数，这里的单词指的是连续的不是空格的字符。
     请注意，你可以假定字符串里不包括任何不可打印的字符。
     示例:
     输入: "Hello, my name is John"
     输出: 5
     解释: 这里的单词是指连续的不是空格的字符，所以 "Hello," 算作 1 个单词。
     */
    static func countSegments(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        let chars = s.map { $0 }
        var count = 0
        var preC: Character = " "
        for c in chars {
            if preC != " ", c == " " {
                count += 1
            }
            preC = c
        }
        return preC == " " ? count : count + 1
    }
    
    // MARK: - 58.最后一个单词的长度
    /*
     给你一个字符串 s，由若干单词组成，单词前后用一些空格字符隔开。返回字符串中 最后一个 单词的长度。
     单词 是指仅由字母组成、不包含任何空格字符的最大子字符串。
     示例 1：
     输入：s = "Hello World"
     输出：5
     解释：最后一个单词是“World”，长度为5。
     
     示例 2：
     输入：s = "   fly me   to   the moon  "
     输出：4
     解释：最后一个单词是“moon”，长度为4。
     
     示例 3：
     输入：s = "luffy is still joyboy"
     输出：6
     解释：最后一个单词是长度为6的“joyboy”。
     
     提示：
     1 <= s.length <= 104
     s 仅有英文字母和空格 ' ' 组成
     s 中至少存在一个单词
     */
    static func lengthOfLastWord(_ s: String) -> Int {
        let count = s.count
        let chars = s.map { $0 }
        var i = count - 1
        var isStart = false
        var result = 0
        while i >= 0 {
            if chars[i] != " " {
                if !isStart {
                    isStart = true
                }
                result += 1
            } else {
                if isStart {
                    return result
                }
            }
            i -= 1
        }
        return result
    }
    
    // MARK: - 344.反转字符串
    /*
     编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。
     不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
     示例 1：
     输入：s = ["h","e","l","l","o"]
     输出：["o","l","l","e","h"]
     
     示例 2：
     输入：s = ["H","a","n","n","a","h"]
     输出：["h","a","n","n","a","H"]
     
     提示：
     1 <= s.length <= 105
     s[i] 都是 ASCII 码表中的可打印字符
     */
    static func reverseString(_ s: inout [Character]) {
        var i = 0
        var j = s.count - 1
        while i < j {
            (s[i], s[j]) = (s[j], s[i])
            i += 1
            j -= 1
        }
    }
    
    // MARK: - 541.反转字符串 II
    /*
     给定一个字符串 s 和一个整数 k，从字符串开头算起，每计数至 2k 个字符，就反转这 2k 字符中的前 k 个字符。
     如果剩余字符少于 k 个，则将剩余字符全部反转。
     如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。
     示例 1：
     输入：s = "abcdefg", k = 2
     输出："bacdfeg"
     
     示例 2：
     输入：s = "abcd", k = 2
     输出："bacd"
     
     提示：
     1 <= s.length <= 104
     s 仅由小写英文组成
     1 <= k <= 104
     */
    static func reverseStr(_ s: String, _ k: Int) -> String {
        var result: String = ""
        let chars = s.map { $0 }
        let times = s.count / (2 * k)
        let left = s.count % (2 * k)
        for i in 0..<times {
            result.append(String(chars[i * 2 * k..<i * 2 * k + k].reversed()))
            result.append(String(chars[i * 2 * k + k..<i * 2 * k + 2 * k]))
        }
        if left > k {
            result.append(String(chars[times * 2 * k..<times * 2 * k + k].reversed()))
            result.append(String(chars[times * 2 * k + k..<chars.count]))
        } else {
            result.append(String(chars[times * 2 * k..<times * 2 * k + left].reversed()))
        }
        return result
    }
    
    // MARK: - 557.反转字符串中的单词 III
    /*
     给定一个字符串 s ，你需要反转字符串中每个单词的字符顺序，同时仍保留空格和单词的初始顺序。
     
     示例 1：
     输入：s = "Let's take LeetCode contest"
     输出："s'teL ekat edoCteeL tsetnoc"
     
     示例 2:
     输入： s = "God Ding"
     输出："doG gniD"
     
     提示：
     1 <= s.length <= 5 * 104
     s 包含可打印的 ASCII 字符。
     s 不包含任何开头或结尾空格。
     s 里 至少 有一个词。
     s 中的所有单词都用一个空格隔开。
     */
    static func reverseWords(_ s: String) -> String {
        let chars = s.map { $0 }
        var result = ""
        let count = chars.count
        var i = 0
        var currentWordChars = [Character]()
        while i < count {
            let char = chars[i]
            if char == " " {
                result.append(String(currentWordChars))
                result.append(" ")
                currentWordChars = []
            } else {
                currentWordChars.insert(char, at: 0)
            }
            i += 1
        }
        result.append(String(currentWordChars))
        return result
    }
    
    // MARK: - 151.颠倒字符串中的单词
    /*
     给你一个字符串 s ，颠倒字符串中 单词 的顺序。
     单词 是由非空格字符组成的字符串。s 中使用至少一个空格将字符串中的 单词 分隔开。
     返回 单词 顺序颠倒且 单词 之间用单个空格连接的结果字符串。
     注意：输入字符串 s中可能会存在前导空格、尾随空格或者单词间的多个空格。返回的结果字符串中，单词间应当仅用单个空格分隔，且不包含任何额外的空格。
     
     示例 1：
     输入：s = "the sky is blue"
     输出："blue is sky the"
     
     示例 2：
     输入：s = "  hello world  "
     输出："world hello"
     解释：颠倒后的字符串中不能存在前导空格和尾随空格。
     
     示例 3：
     输入：s = "a good   example"
     输出："example good a"
     解释：如果两个单词间有多余的空格，颠倒后的字符串需要将单词间的空格减少到仅有一个。
     
     提示：
     1 <= s.length <= 104
     s 包含英文大小写字母、数字和空格 ' '
     s 中 至少存在一个 单词
     */
    static func reverseSentenceWords(_ s: String) -> String {
        let chars = s.map { $0 }
        var start = 0
        var end = chars.count - 1
        while chars[start] == " " || chars[end] == " " {
            if chars[start] == " " {
                start += 1
            }
            if chars[end] == " " {
                end -= 1
            }
        }
        var words = [[Character]]()
        var i = start
        var j = end
        var currentWord = [Character]()
        var preC: Character = " "
        while i <= j {
            let c = chars[i]
            if c == " " {
                if preC != " " {
                    words.append(currentWord)
                    currentWord = []
                }
            } else {
                currentWord.append(c)
            }
            preC = c
            i += 1
        }
        words.append(currentWord)
        
        var result = ""
        var wordIndex = words.count - 1
        while wordIndex >= 0 {
            result.append(String(words[wordIndex]))
            if wordIndex > 0 {
                result.append(" ")
            }
            wordIndex -= 1
        }
        return result
    }
    
    // MARK: - 387.字符串中的第一个唯一字符
    /*
     给定一个字符串 s ，找到 它的第一个不重复的字符，并返回它的索引 。如果不存在，则返回 -1 。
     示例 1：
     输入: s = "leetcode"
     输出: 0
     
     示例 2:
     输入: s = "loveleetcode"
     输出: 2
     
     示例 3:
     输入: s = "aabb"
     输出: -1
     
     提示:
     1 <= s.length <= 105
     s 只包含小写字母
     */
    static func firstUniqChar(_ s: String) -> Int {
        let chars = s.map { $0 }
        var indexMap = [Character : Int]()
        for i in 0..<chars.count {
            if let _ = indexMap[chars[i]] {
                indexMap[chars[i]] = -1
            } else {
                indexMap[chars[i]] = i
            }
        }
        var result = Int.max
        for index in indexMap.values {
            if index != -1 {
                result = min(result, index)
            }
        }
        return result == Int.max ? -1 : result
    }
}
