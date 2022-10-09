//
//  String.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class ALString {
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
    
    // MARK: - 389. 找不同
    /*
     给定两个字符串 s 和 t ，它们只包含小写字母。
     字符串 t 由字符串 s 随机重排，然后在随机位置添加一个字母。
     请找出在 t 中被添加的字母。
     
     示例 1：
     输入：s = "abcd", t = "abcde"
     输出："e"
     解释：'e' 是那个被添加的字母。
     
     示例 2：
     输入：s = "", t = "y"
     输出："y"
      
     提示：
     0 <= s.length <= 1000
     t.length == s.length + 1
     s 和 t 只包含小写字母
     */
    static func findTheDifference(_ s: String, _ t: String) -> Character {
        // 计数
        /*
        var result: Character?
        var countArr = [Int](repeating: 0, count: 26)
        for c in s.map({ $0 }) {
            let letterIndex = Int(c.asciiValue! - ("a" as Character).asciiValue!)
            countArr[letterIndex] = countArr[letterIndex] + 1
        }
        for c in t.map({ $0 }) {
            let letterIndex = Int(c.asciiValue! - ("a" as Character).asciiValue!)
            if countArr[letterIndex] == 0 {
                result = c
                break
            } else {
                countArr[letterIndex] = countArr[letterIndex] - 1
            }
        }
        return result!
         */
        // 位运算
        var result: Int = 0
        let tChars = Array(t)
        let sChars = Array(s)
        let tCharsCount = tChars.count
        let sCharsCount = sChars.count
        for i in 0..<tCharsCount {
            let tCharAsciiValue = Int(tChars[i].asciiValue!)
            result = result ^ tCharAsciiValue
            if i < sCharsCount {
                let sCharAsciiValue = Int(sChars[i].asciiValue!)
                result = result ^ sCharAsciiValue
            }
        }
        return Character(UnicodeScalar(result)!)
    }
    
    // MARK: - 383. 赎金信
    /*
     给你两个字符串：ransomNote 和 magazine ，判断 ransomNote 能不能由 magazine 里面的字符构成。
     如果可以，返回 true ；否则返回 false 。
     magazine 中的每个字符只能在 ransomNote 中使用一次。
     
     示例 1：
     输入：ransomNote = "a", magazine = "b"
     输出：false
     
     示例 2：
     输入：ransomNote = "aa", magazine = "ab"
     输出：false
     
     示例 3：
     输入：ransomNote = "aa", magazine = "aab"
     输出：true
     
     提示：
     1 <= ransomNote.length, magazine.length <= 105
     ransomNote 和 magazine 由小写英文字母组成
     */
    static func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        let ransomNoteChars = Array(ransomNote)
        let magazineChars = Array(magazine)
        var charCountMap = [Character : Int]()
        for c in ransomNoteChars {
            charCountMap[c] = (charCountMap[c] ?? 0) + 1
        }
        for c in magazineChars {
            if let count = charCountMap[c], count > 0 {
                charCountMap[c] = count - 1
            }
        }
        return charCountMap.values.max() == 0
    }
    
    // MARK: - 242.有效的字母异位词
    /*
     给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
     注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。
     
     示例 1:
     输入: s = "anagram", t = "nagaram"
     输出: true
     
     示例 2:
     输入: s = "rat", t = "car"
     输出: false
     
     提示:
     1 <= s.length, t.length <= 5 * 104
     s 和 t 仅包含小写字母

     进阶: 如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
     */
    static func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        let sChars = Array(s)
        let tChars = Array(t)
        var charCountMap = [Character : Int]()
        for c in sChars {
            charCountMap[c] = (charCountMap[c] ?? 0) + 1
        }
        for c in tChars {
            if let count = charCountMap[c] {
                if count > 0 {
                    charCountMap[c] = count - 1
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }
    
    // MARK: - 49.字母异位词分组 (中等)
    /*
     给你一个字符串数组，请你将 字母异位词 组合在一起。可以按任意顺序返回结果列表。
     字母异位词 是由重新排列源单词的字母得到的一个新单词，所有源单词中的字母通常恰好只用一次。

     示例 1:
     输入: strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
     输出: [["bat"],["nat","tan"],["ate","eat","tea"]]
     
     示例 2:
     输入: strs = [""]
     输出: [[""]]
     
     示例 3:
     输入: strs = ["a"]
     输出: [["a"]]
     
     提示：
     1 <= strs.length <= 104
     0 <= strs[i].length <= 100
     strs[i] 仅包含小写字母
     */
    static func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dict = [String : [String]]()
        for str in strs {
            let sortedStr = String(str.sorted())
            if var arr = dict[sortedStr] {
                arr.append(str)
                dict[sortedStr] = arr
            } else {
                dict[sortedStr] = [str]
            }
        }
        return dict.values.map { $0 }
    }
    
    // MARK: - 451.根据字符出现频率排序
    /*
     给定一个字符串 s ，根据字符出现的 频率 对其进行 降序排序 。一个字符出现的 频率 是它出现在字符串中的次数。
     返回 已排序的字符串 。如果有多个答案，返回其中任何一个。

     示例 1:
     输入: s = "tree"
     输出: "eert"
     解释: 'e'出现两次，'r'和't'都只出现一次。
     因此'e'必须出现在'r'和't'之前。此外，"eetr"也是一个有效的答案。
     
     示例 2:
     输入: s = "cccaaa"
     输出: "cccaaa"
     解释: 'c'和'a'都出现三次。此外，"aaaccc"也是有效的答案。
     注意"cacaca"是不正确的，因为相同的字母必须放在一起。
     
     示例 3:
     输入: s = "Aabb"
     输出: "bbAa"
     解释: 此外，"bbaA"也是一个有效的答案，但"Aabb"是不正确的。
     注意'A'和'a'被认为是两种不同的字符。
      
     提示:
     1 <= s.length <= 5 * 105
     s 由大小写英文字母和数字组成
     */
    static func frequencySort(_ s: String) -> String {
        let chars = Array(s)
        var countMap = [Character : Int]()
        for c in chars {
            countMap[c] = (countMap[c] ?? 0) + 1
        }
        let sortedStr = countMap.sorted(by: { $0.value > $1.value }).map { $0.key }
        var result = [Character]()
        for c in sortedStr {
            let count: Int = countMap[c]!
            for _ in 0..<count {
                result.append(c)
            }
        }
        return String(result)
    }
    
    // MARK: - 423.从英文中重建数字 (中等)
    /*
     给你一个字符串 s ，其中包含字母顺序打乱的用英文单词表示的若干数字（0-9）。按 升序 返回原始的数字。
     示例 1：
     输入：s = "owoztneoer"
     输出："012"
     
     示例 2：
     输入：s = "fviefuro"
     输出："45"
     
     提示：
     1 <= s.length <= 105
     s[i] 为 ["e","g","f","i","h","o","n","s","r","u","t","w","v","x","z"] 这些字符之一
     s 保证是一个符合题目要求的字符串
     */
    static func originalDigits(_ s: String) -> String {
        var result = ""
        let chars = Array(s)
        var map = [Character : Int]()
        for c in chars {
            map[c] = (map[c] ?? 0) + 1
        }
        var arr = [Int](repeating: 0, count: 10)
        arr[0] = map["z"] ?? 0
        arr[2] = map["w"] ?? 0
        arr[4] = map["u"] ?? 0
        arr[6] = map["x"] ?? 0
        arr[8] = map["g"] ?? 0
        
        arr[3] = (map["h"] ?? 0) - arr[8]
        arr[5] = (map["f"] ?? 0) - arr[4]
        arr[7] = (map["s"] ?? 0) - arr[6]
        
        arr[1] = (map["o"] ?? 0) - arr[0] - arr[2] - arr[4]
        arr[9] = (map["i"] ?? 0) - arr[5] - arr[6] - arr[8]
        
        for i in 0..<10 {
            for j in 0..<arr[i] {
                result += "\(i)"
            }
        }
        
        return result
    }
    
    // MARK: - 657. 机器人能否返回原点
    static func judgeCircle(_ moves: String) -> Bool {
        var map: [Character : Int] = ["L" : 0, "R" : 0, "U" : 0, "D" : 0]
        let chars = Array(moves)
        for c in chars {
            map[c] = map[c]! + 1
        }
        if map["L"] == map["R"] && map["U"] == map["D"] {
            return true
        }
        return false
    }
    
    // MARK: - 551. 学生出勤记录 I
    static func checkRecord(_ s: String) -> Bool {
        let chars = Array(s)
        var absentCount = 0
        var continuouslyLateCount = 0
        for c in chars {
            if c == "A" {
                absentCount += 1
                continuouslyLateCount = 0
            } else if c == "L" {
                continuouslyLateCount += 1
                if continuouslyLateCount >= 3 {
                    return false
                }
            } else {
                continuouslyLateCount = 0
            }
        }
        return absentCount < 2
    }
    
    // MARK: - 696. 计数二进制子串
    static func countBinarySubstrings(_ s: String) -> Int {
        let chars = Array(s)
        let n = chars.count
        var i = 0
        var last = 0
        var ans = 0
        while i < n {
            let c = chars[i]
            var count = 0
            while i < n && chars[i] == c {
                i += 1
                count += 1
            }
            ans += min(count, last)
            last = count
        }
        return ans
    }
    
    // MARK: - 467. 环绕字符串中唯一的子字符串（中等）
    static func findSubstringInWraproundString(_ p: String) -> Int {
        let chars = Array(p)
        var dp = [Int](repeating: 0, count: 26)
        var k = 0
        for i in 0..<chars.count {
            if i > 0 {
                let a = Int(chars[i].asciiValue!)
                let b = Int(chars[i-1].asciiValue!)
                if (a - b + 26) % 26 == 1 {
                    k += 1
                } else {
                    k = 1
                }
            } else {
                k = 1
            }
            let value = Int(chars[i].asciiValue! - Character("a").asciiValue!)
            dp[value] = max(dp[value], k)
        }
        var ans = 0
        for i in 0..<dp.count {
            ans += dp[i]
        }
        return ans
    }
    
    // MARK: - 535. TinyURL 的加密与解密
    class Codec {
        private var dataBase = [Int : String]()
        // Encodes a URL to a shortened URL.
        func encode(_ longUrl: String) -> String {
            var key: Int = 0
            while true {
                key = (0..<Int.max).randomElement()!
                if dataBase[key] == nil {
                    break
                }
            }
            dataBase[key] = longUrl
            return "http://tinyurl.com/\(key)"
        }
        
        // Decodes a shortened URL to its original URL.
        func decode(_ shortUrl: String) -> String {
            let index = shortUrl.lastIndex(of: "/")!
            let key = shortUrl[shortUrl.index(after: index)..<shortUrl.endIndex]
            return dataBase[Int(key)!]!
        }
    }
    
    // MARK: - 299. 猜数字游戏（中等）
    static func getHint(_ secret: String, _ guess: String) -> String {
        var map = [Character : Int]()
        let sChars = Array(secret)
        let gChars = Array(guess)
        for c in sChars {
            map[c] = (map[c] ?? 0) + 1
        }
        let len = sChars.count
        var x = 0
        for i in 0..<len {
            if sChars[i] == gChars[i] {
                x += 1
                map[sChars[i]] = map[sChars[i]]! - 1
            }
        }
        var y = 0
        for i in 0..<len {
            if sChars[i] != gChars[i], let count = map[gChars[i]], count > 0 {
                y += 1
                map[gChars[i]] = count - 1
            }
        }
        return "\(x)A\(y)B"
    }
    
    // MARK: - 412. Fizz Buzz
    static func fizzBuzz(_ n: Int) -> [String] {
        var ans = [String]()
        for i in 1...n {
            if i % 3 == 0 && i % 5 == 0 {
                ans.append("FizzBuzz")
            } else if i % 3 == 0 {
                ans.append("Fizz")
            } else if i % 5 == 0 {
                ans.append("Buzz")
            } else {
                ans.append("\(i)")
            }
        }
        return ans
    }
    
    // MARK: - 506. 相对名次
    static func findRelativeRanks(_ score: [Int]) -> [String] {
        // 排序
        /*
        let sortedScore = score.sorted(by: >)
        var ans = [String]()
        for score in score {
            let rank = sortedScore.firstIndex(of: score)! + 1
            if rank == 1 {
                ans.append("Gold Medal")
            } else if rank == 2 {
                ans.append("Silver Medal")
            } else if rank == 3 {
                ans.append("Bronze Medal")
            } else {
                ans.append("\(rank)")
            }
        }
        return ans
         */
        // 同时保存下标和值
        var arr = [(index: Int, value: Int)]()
        let len = score.count
        for i in 0..<len {
            arr.append((i, score[i]))
        }
        let strArr = ["Gold Medal", "Silver Medal", "Bronze Medal"]
        let sortedArr = arr.sorted(by: { $0.value > $1.value })
        var ans = [String](repeating: "", count: len)
        for i in 0..<len {
            if i >= 3 {
                ans[sortedArr[i].index] = "\(i + 1)"
            } else {
                ans[sortedArr[i].index] = strArr[i]
            }
        }
        return ans
    }
    
    // MARK: - 539. 最小时间差（中等）
    static func findMinDifference(_ timePoints: [String]) -> Int {
        let len = timePoints.count
        if len > 1440 { return 0 }
        var allMinutes = [Int]()
        for time in timePoints {
            let arr = time.components(separatedBy: ":")
            let hourChars = Array(arr[0])
            let hour = arr[0].hasPrefix("0") ? Int(String(hourChars[1]))! : Int(arr[0])!
            let minuteChars = Array(arr[1])
            let minute = arr[1].hasPrefix("0") ? Int(String(minuteChars[1]))! : Int(arr[1])!
            allMinutes.append(hour * 60 + minute)
        }
        let sortedMinutes = allMinutes.sorted()
        var ans = Int.max
        for i in 1..<len {
            ans = min(sortedMinutes[i] - sortedMinutes[i - 1], ans)
        }
        // 第一个和最后一个的时间差
        ans = min(sortedMinutes[0] + 1440 - sortedMinutes[len - 1], ans)
        return ans
    }
    
    // MARK: - 553. 最优除法（中等）
    static func optimalDivision(_ nums: [Int]) -> String {
        // 数学
        let n = nums.count
        if n == 1 { return "\(nums[0])" }
        if n == 2 { return "\(nums[0])/\(nums[1])" }
        var s = "\(nums[1])"
        for i in 2..<n {
            s += "/\(nums[i])"
        }
        return "\(nums[0])/(\(s))"
    }
    
    // MARK: - 537. 复数乘法（中等）
    static func complexNumberMultiply(_ num1: String, _ num2: String) -> String {
        let arr1 = num1.components(separatedBy: "+")
        let arr2 = num2.components(separatedBy: "+")
        let num1Left = Int(arr1[0])!
        let num1RightStr = arr1[1]
        let num1Right = Int(num1RightStr[num1RightStr.startIndex..<num1RightStr.index(before: num1RightStr.endIndex)])!
        let num2Left = Int(arr2[0])!
        let num2RightStr = arr2[1]
        let num2Right = Int(num2RightStr[num2RightStr.startIndex..<num2RightStr.index(before: num2RightStr.endIndex)])!
        let ansLeft = num1Left * num2Left - (num1Right * num2Right)
        let ansRight = num1Left * num2Right + num1Right * num2Left
        return "\(ansLeft)+\(ansRight)i"
    }
    
    // MARK: - 592. 分数加减运算（中等）
    static func fractionAddition(_ expression: String) -> String {
        func gcd(_ x: Int, _ y: Int) -> Int {
            return y > 0 ? gcd(y, x % y) : x
        }
        
        var numsPair = [(t: Int, b: Int)]()
        var chars = Array(expression)
        if chars.first != "+" && chars.first != "-" {
            chars.insert("+", at: 0)
        }
        let n = chars.count
        var i = 0
        var start = 0
        while i < n {
            if i + 1 == n || (chars[i + 1] == "+" || chars[i + 1] == "-") {
                let str = String(chars[start...i])
                let arr = str.components(separatedBy: "/")
                numsPair.append((Int(arr[0])!, Int(arr[1])!))
                start = i + 1
            }
            i += 1
        }
        var cur = numsPair[0]
        for i in 1..<numsPair.count {
            let newB = cur.b * numsPair[i].b / gcd(cur.b, numsPair[i].b)
            let newT = (newB / cur.b) * cur.t + (newB / numsPair[i].b) * numsPair[i].t
            cur = (newT, newB)
        }
        let f = gcd(abs(cur.t), cur.b)
        if cur.t % cur.b == 0 {
            return "\(cur.t / cur.b)/1"
        }
        return "\(cur.t/f)/\(cur.b/f)"
    }
    
    // MARK: - 640. 求解方程（中等）
    static func solveEquation(_ equation: String) -> String {
        // 吐血解法
        /*
        let arr = equation.components(separatedBy: "=")
        var start = 0
        let left = Array(arr[0])
        var final = [[Character]]()
        for i in 0..<left.count {
            let c = left[i]
            let isLast = i == left.count - 1
            if c == "+" || c == "-" || isLast {
                let end = isLast ? i + 1 : i
                if end <= start { continue }
                var value = Array(left[start..<end])
                if value[0] != "+" && value[0] != "-" {
                    value.insert("+", at: 0)
                }
                final.append(value)
                start = i
            }
        }
        start = 0
        let right = Array(arr[1])
        for i in 0..<right.count {
            let c = right[i]
            let isLast = i == right.count - 1
            if c == "+" || c == "-" || isLast {
                let end = isLast ? i + 1 : i
                if end <= start { continue }
                var value = Array(right[start..<end])
                if value[0] == "+" {
                    value[0] = "-"
                } else if value[0] == "-" {
                    value[0] = "+"
                } else {
                    value.insert("-", at: 0)
                }
                final.append(value)
                start = i
            }
        }
        var xLeft = 0
        var numSum = 0
        for e in final {
            let sign = e[0] == "-" ? -1 : 1
            if e[e.count - 1] == "x" {
                let num = String(e[1..<e.count - 1])
                xLeft += sign * Int(num.isEmpty ? "1" : num)!
            } else {
                numSum += sign * Int(String(e[1..<e.count]))!
            }
        }
        if xLeft == 0 && numSum == 0 {
            return "Infinite solutions"
        } else if (xLeft == 0 && numSum != 0) || numSum % xLeft != 0 {
            return "No solution"
        } else {
            return "x=\(-numSum / xLeft)"
        }
         */
        var factor = 0; var val = 0
        var index = 0; let n = equation.count; var sign1 = 1
        let chars = Array(equation)
        while index < n {
            // 等号后面全部乘以负一
            if chars[index] == "=" {
                sign1 = -1
                index += 1
                continue
            }
            // 全部移到等号左边的符号
            var sign2 = sign1
            var number = 0
            // number是否有效
            var valid = false
            // 碰到"-"或者"+"
            if chars[index] == "-" || chars[index] == "+" {
                sign2 = (chars[index] == "-") ? -sign1 : sign1
                index += 1
            }
            // 遍历数字
            while index < n && chars[index].isNumber {
                number = number * 10 + Int(String(chars[index]))!
                index += 1
                valid = true
            }
            // 数字后面跟着x
            if index < n && chars[index] == "x" {
                factor += valid ? sign2 * number : sign2
                index += 1
            } else {
                val += sign2 * number
            }
        }
        if factor == 0 {
            return val == 0 ? "Infinite solutions" : "No solution"
        }
        return "x=\(-val / factor)"
    }
    
    // MARK: - 38. 外观数列（中等）
    static func countAndSay(_ n: Int) -> String {
        var cur = n - 1
        var ans = "1"
        while cur > 0 {
            let len = ans.count
            let chars = Array(ans)
            var numCount = 1
            var curStr = ""
            for i in 0..<len {
                if i < len - 1, chars[i] == chars[i+1] {
                    numCount += 1
                } else {
                    curStr += "\(numCount)\(chars[i])"
                    numCount = 1
                }
            }
            ans = curStr
            cur -= 1
        }
        return ans
    }
    
    // MARK: - 443. 压缩字符串（中等）
    static func compress(_ chars: inout [Character]) -> Int {
        // 双指针
        let n = chars.count
        // 返回书序新长度
        var j = 0
        // 重复字符的左边下标
        var left = 0
        for i in 0..<n {
            // 遍历到字符串末尾，或者当前字符和下一个字符不同时
            if i == n - 1 || chars[i] != chars[i + 1] {
                // 插入当前字符
                chars[j] = chars[i]
                // 计算重复字符个数
                let num = i - left + 1
                j += 1
                if num > 1 {
                    let str = "\(num)"
                    for k in 0..<str.count {
                        chars[j] = Array(str)[k]
                        j += 1
                    }
                }
                left = i + 1
            }
        }
        return j
    }
    
    // MARK: - 8. 字符串转换整数 (atoi)
    static func myAtoi(_ s: String) -> Int {
        let chars = Array(s)
        let len = chars.count
        var i = 0; var sign = 1; var ans = 0
        // 去掉前导空格
        while i < len, chars[i] == " " {
            i += 1
        }
        if i >= len { return 0 }
        // 判断负号
        if chars[i] == "-" {
            sign = -1
        }
        // 有+或-向后移动一位
        if chars[i] == "+" || chars[i] == "-" {
            i += 1
        }
        // 碰到不是数字的就终止
        while i < len, chars[i].isNumber {
            let num = Int(String(chars[i]))!
            if sign == 1 && (Int(Int32.max) - num) / 10 < ans {
                return Int(Int32.max)
            } else if sign == -1 && (Int(Int32.min) + num) / 10 > -ans {
                return Int(Int32.min)
            }
            ans = ans * 10 + num
            i += 1
        }
        return sign * ans
    }
    
    // MARK: - 13. 罗马数字转整数
    static func romanToInt(_ s: String) -> Int {
        /*
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
         */
        let romanIntMap: [Character : Int] = ["I" : 1,
                                              "V" : 5,
                                              "X" : 10,
                                              "L" : 50,
                                              "C" : 100,
                                              "D" : 500,
                                              "M" : 1000]
        let chars = Array(s)
        let len = chars.count
        var ans = 0
        for i in 0..<len {
            let value = romanIntMap[chars[i]]!
            if i < len - 1 && value < romanIntMap[chars[i + 1]]! {
                ans -= value
            } else {
                ans += value
            }
        }
        return ans
    }
    
    // MARK: - 12. 整数转罗马数字（中等）
    static func intToRoman(_ num: Int) -> String {
        let arr = [(1000, "M"),
                   (900, "CM"),
                   (500, "D"),
                   (400, "CD"),
                   (100, "C"),
                   (90, "XC"),
                   (50, "L"),
                   (40, "XL"),
                   (10, "X"),
                   (9, "IX"),
                   (5, "V"),
                   (4, "IV"),
                   (1, "I")]
        var ans = ""
        var num = num
        for (key, value) in arr {
            while num >= key {
                num -= key
                ans += value
            }
            if num == 0 {
                break
            }
        }
        
        return ans
    }
    
    // MARK: - 165. 比较版本号（中等）
    static func compareVersion(_ version1: String, _ version2: String) -> Int {
        // 分隔成数组
        /*
        let version1Nums = version1.components(separatedBy: ".")
        let version2Nums = version2.components(separatedBy: ".")
        for i in 0..<max(version1Nums.count, version2Nums.count) {
            var v1 = "0"
            if i < version1Nums.count {
                v1 = version1Nums[i]
            }
            while v1.count > 1, v1.hasPrefix("0") {
                v1.removeFirst()
            }
            var v2 = "0"
            if i < version2Nums.count {
                v2 = version2Nums[i]
            }
            while v2.count > 1, v2.hasPrefix("0") {
                v2.removeFirst()
            }
            if Int(v1)! > Int(v2)! {
                return 1
            } else if Int(v1)! < Int(v2)! {
                return -1
            }
        }
        return 0
         */
        
        // 双指针
        var i = 0
        var j = 0
        let chars1 = Array(version1)
        let n = chars1.count
        let chars2 = Array(version2)
        let m = chars2.count
        while i < n || j < m {
            var x = 0
            while i < n, chars1[i] != "." {
                x = x * 10 + Int(String(chars1[i]))!
                i += 1
            }
            i += 1
            var y = 0
            while j < m, chars2[j] != "." {
                y = y * 10 + Int(String(chars2[j]))!
                j += 1
            }
            j += 1
            if x != y {
                return x > y ? 1 : -1
            }
        }
        return 0
    }
    
    // MARK: - 481. 神奇字符串（中等）
    static func magicalString(_ n: Int) -> Int {
        if n <= 3 { return 1 }
        let str = "122"
        var i = 2
        var chars = Array(str)
        var len = chars.count
        while len < n {
            let lastChar = chars[len - 1]
            if chars[i] == "1" {
                if lastChar == "1" {
                    chars.append("2")
                } else {
                    chars.append("1")
                }
                len += 1
            } else {
                if lastChar == "1" {
                    chars.append(contentsOf: [Character("2"), Character("2")])
                } else {
                    chars.append(contentsOf: [Character("1"), Character("1")])
                }
                len += 2
            }
            i += 1
        }
        var ans = 0
        for i in 0..<n {
            if chars[i] == "1" {
                ans += 1
            }
        }
        return ans
    }
    
    // MARK: - 392. 判断子序列
    static func isSubsequence(_ s: String, _ t: String) -> Bool {
        // 双指针
        /*
        var i = 0
        var j = 0
        let sChars = Array(s)
        let tChars = Array(t)
        let n = sChars.count
        let m = tChars.count
        while i < n && j < m {
            if sChars[i] == tChars[j] {
                i += 1
            }
            j += 1
        }
        return i == n
        */
        // 动态规划
        let tChars = Array(t); let sChars = Array(s)
        let sLen = s.count; let tLen = t.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 26), count: tLen + 1)
        for i in 0..<26 {
            dp[tLen][i] = tLen
        }
        for i in (0..<tLen).reversed() {
            for j in 0..<26 {
                let aAscii = Int(Character("a").asciiValue!)
                if tChars[i] == Character(UnicodeScalar(aAscii + j)!) {
                    dp[i][j] = i
                } else {
                    dp[i][j] = dp[i + 1][j]
                }
            }
        }
        var add = 0
        for i in 0..<sLen {
            let aAscii = Int(Character("a").asciiValue!)
            let sAscii = Int(sChars[i].asciiValue!)
            if dp[add][sAscii - aAscii] == tLen {
                return false
            }
            add = dp[add][sAscii - aAscii] + 1
        }
        return true
    }
    
    // MARK: - 524. 通过删除字母匹配到字典里最长单词（中等）
    static func findLongestWord(_ s: String, _ dictionary: [String]) -> String {
        // 双指针
        let sChars = Array(s)
        let sLen = sChars.count
        var ans = ""
        for str in dictionary {
            let chars = Array(str)
            var i = 0; var j = 0
            let dLen = chars.count
            while i < sLen && j < dLen {
                if sChars[i] == chars[j] {
                    j += 1
                }
                i += 1
            }
            if j == dLen {
                if dLen > ans.count || (dLen == ans.count && str < ans) {
                    ans = str
                }
            }
        }
        return ans
    }
    
    // MARK: - 521. 最长特殊序列 Ⅰ
    static func findLUSlength(_ a: String, _ b: String) -> Int {
        let aLen = a.count; let bLen = b.count
        if a == b {
            return -1
        }
        return max(aLen, bLen)
    }
    
    // MARK: - 522. 最长特殊序列 II（中等）
    static func findLUSlength(_ strs: [String]) -> Int {
        func isSubsequence(_ s: String, _ t: String) -> Bool {
            var i = 0
            var j = 0
            let sChars = Array(s)
            let tChars = Array(t)
            let n = sChars.count
            let m = tChars.count
            while i < n && j < m {
                if sChars[i] == tChars[j] {
                    i += 1
                }
                j += 1
            }
            return i == n
        }
        let len = strs.count
        var ans = -1
        for i in 0..<len {
            var isCheck = true
            for j in 0..<len {
                if i != j, isSubsequence(strs[i], strs[j]) {
                    isCheck = false
                    break
                }
            }
            if isCheck {
                ans = max(ans, strs[i].count)
            }
        }
        return ans
    }
    
    // MARK: - 66. 加一
    static func plusOne(_ digits: [Int]) -> [Int] {
        var ans = digits
        let len = digits.count
        var i = len - 1; var inc = 1;
        while i >= 0 {
            let num = ans[i]
            let res = num + inc
            if res >= 10 {
                inc = 1
                ans[i] = res - 10
            } else {
                inc = 0
                ans[i] = res
            }
            i -= 1
        }
        if inc == 1 {
            ans.insert(1, at: 0)
        }
        return ans
    }
    
    // MARK: - 67. 二进制求和
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
    
    // MARK: - 415. 字符串相加
    static func addStrings(_ num1: String, _ num2: String) -> String {
        let num1Chars = Array(num1); let num2Chars = Array(num2)
        var i = num1.count - 1; var j = num2.count - 1; var inc = 0
        var ans = ""
        while i >= 0 || j >= 0 || inc != 0 {
            let x = i >= 0 ? Int(String(num1Chars[i]))! : 0
            let y = j >= 0 ? Int(String(num2Chars[j]))! : 0
            let res = x + y + inc
            inc = res / 10
            ans.append("\(res % 10)")
            i -= 1
            j -= 1
        }
        return String(ans.reversed())
    }
    
    // 43. 字符串相乘（中等）
    static func multiply(_ num1: String, _ num2: String) -> String {
        // 加法运算
        /*
        func addStrings(_ num1: String, _ num2: String) -> String {
            let num1Chars = Array(num1); let num2Chars = Array(num2)
            var i = num1.count - 1; var j = num2.count - 1; var inc = 0
            var ans = ""
            while i >= 0 || j >= 0 || inc != 0 {
                let x = i >= 0 ? Int(String(num1Chars[i]))! : 0
                let y = j >= 0 ? Int(String(num2Chars[j]))! : 0
                let res = x + y + inc
                inc = res / 10
                ans.append("\(res % 10)")
                i -= 1
                j -= 1
            }
            return String(ans.reversed())
        }
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        let num1Chars = Array(num1); let num2Chars = Array(num2)
        let len1 = num1.count; let len2 = num2.count
        var ans = ""
        for i in (0..<len1).reversed() {
            var cur = ""
            // 后面补零
            for j in 0..<len1-1-i {
                cur.append("0")
            }
            let x = Int(String(num1Chars[i]))!
            var inc = 0
            for j in (0..<len2).reversed() {
                let y = Int(String(num2Chars[j]))!
                let res = x * y + inc
                cur.append("\(res % 10)")
                inc = res / 10
            }
            if inc != 0 {
                cur.append("\(inc)")
            }
            print(String(cur.reversed()))
            ans = addStrings(ans, String(cur.reversed()))
        }
        return ans
         */
        
        // 乘法运算
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        let num1Chars = Array(num1); let num2Chars = Array(num2)
        let len1 = num1.count; let len2 = num2.count
        // 存储字符串的数字数组
        var arr = [Int](repeating: 0, count: len1 + len2)
        for i in (0..<len1).reversed() {
            let x = Int(String(num1Chars[i]))!
            for j in (0..<len2).reversed() {
                let y = Int(String(num2Chars[j]))!
                arr[i + j + 1] += x * y
            }
        }
        
        for i in (1..<len1+len2).reversed() {
            arr[i - 1] += arr[i] / 10
            arr[i] = arr[i] % 10
        }
        var index = arr[0] == 0 ? 1 : 0
        var ans = ""
        while index < len1 + len2 {
            ans.append("\(arr[index])")
            index += 1
        }
        return ans
    }
    
    // MARK: - 306. 累加数（中等）
//    static func isAdditiveNumber(_ num: String) -> Bool {
//
//    }
    
    // MARK: - 482. 密钥格式化
    static func licenseKeyFormatting(_ s: String, _ k: Int) -> String {
        let s = s.uppercased()
        let arr = s.components(separatedBy: "-")
        let chars = Array(arr.reduce("", { $0 + $1 }))
        let len = chars.count
        var firstStrCount = len % k
        if firstStrCount == 0, len >= k {
            firstStrCount = k
        }
        var ans = String(chars[0..<firstStrCount])
        var i = firstStrCount
        while i < len {
            ans += "-\(String(chars[i..<i + k]))"
            i += k
        }
        return ans
    }
    
    // MARK: - 5. 最长回文子串（中等 Hot 100）
    static func longestPalindrome(_ s: String) -> String {
        /*
         // 第一次想到的解法
        func findLongestPalindrome(_ chars: [Character], centerIndex: Int) -> String {
            let len = chars.count
            var i = centerIndex
            while i > 0, chars[i - 1] == chars[centerIndex] {
                i -= 1
            }
            var j = centerIndex
            while j < len - 1, chars[j + 1] == chars[centerIndex] {
                j += 1
            }
            while i > 0 && j < len - 1 {
                if chars[i - 1] == chars[j + 1] {
                    i -= 1
                    j += 1
                } else {
                    break
                }
            }
            return String(chars[i...j])
        }
        // 中心扩展法
        func expandAroundCenter(_ chars: [Character], left: Int, right: Int) -> Int {
            var left = left; var right = right
            while left >= 0 && right < chars.count && chars[left] == chars[right] {
                left -= 1
                right += 1
            }
            return right - left - 1
        }
        
        let len = s.count
        let chars = Array(s)
        var maxLen = 0
        var start = 0; var end = 0
        for i in 0..<len {
            let len1 = expandAroundCenter(chars, left: i, right: i)
            let len2 = expandAroundCenter(chars, left: i, right: i + 1)
            let curLen = max(len1, len2)
            if curLen > maxLen {
                maxLen = curLen
                start = i - (curLen - 1) / 2
                end = i + curLen / 2
            }
        }
        return String(chars[start...end])
         */
        // 动态规划
        let len = s.count
        if len < 2 {
            return s
        }
        let chars = Array(s)
        // 最短回文子串长度为1，单个字母
        var maxLen = 1; var start = 0
        // dp代表i...j范围的子串是否为回文子串
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: len), count: len)
        // 单个字符为回文子串
        for i in 0..<len {
            dp[i][i] = true
        }
        for j in 1..<len {
            for i in 0..<j {
                if chars[i] != chars[j] {
                    dp[i][j] = false
                } else {
                    if j - i < 3 {
                        dp[i][j] = true
                    } else {
                        dp[i][j] = dp[i+1][j-1]
                    }
                }
                if dp[i][j] && j - i + 1 > maxLen {
                    maxLen = j - i + 1
                    start = i
                }
            }
        }
        return String(chars[start..<start+maxLen])
    }
}
