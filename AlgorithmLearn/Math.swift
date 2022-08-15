//
//  Math.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class Math {
    // MARK: - 7. 整数反转（中等）
    /*
     给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。
     如果反转后整数超过 32 位的有符号整数的范围，就返回 0。
     假设环境不允许存储 64 位整数（有符号或无符号）。
      
     示例 1：
     输入：x = 123
     输出：321
     
     示例 2：
     输入：x = -123
     输出：-321
     
     示例 3：
     输入：x = 120
     输出：21
     
     示例 4：
     输入：x = 0
     输出：0
      
     提示：
     -231 <= x <= 231 - 1
     */
    static func reverse(_ x: Int) -> Int {
        var res = 0
        var x = x
        while x != 0 {
            if res < Int32.min / 10 || res > Int32.max / 10 {
                return 0
            }
            res = res * 10 + x % 10
            x /= 10
        }
        return res
    }
    
    // MARK: - 9. 回文数
    /*
     给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。
     回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。
     例如，121 是回文，而 123 不是。
      
     示例 1：
     输入：x = 121
     输出：true
     
     示例 2：
     输入：x = -121
     输出：false
     解释：从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
     
     示例 3：
     输入：x = 10
     输出：false
     解释：从右向左读, 为 01 。因此它不是一个回文数。
      
     提示：
     -231 <= x <= 231 - 1
     进阶：你能不将整数转为字符串来解决这个问题吗？
     */
    static func isPalindrome(_ x: Int) -> Bool {
        if x < 0 || (x != 0 && x % 10 == 0) {
            return false
        }
        var x = x
        var revertNum = 0
        while x > revertNum {
            revertNum = revertNum * 10 + x % 10
            x /= 10
        }
        return x == revertNum || x == revertNum / 10
    }
    
    // MARK: - 479. 最大回文数乘积（困难）
    /*
     给定一个整数 n ，返回 可表示为两个 n 位整数乘积的 最大回文整数 。因为答案可能非常大，所以返回它对 1337 取余 。
     
     示例 1:
     输入：n = 2
     输出：987
     解释：99 x 91 = 9009, 9009 % 1337 = 987
     
     示例 2:
     输入： n = 1
     输出： 9
     
     提示:
     1 <= n <= 8
     */
    static func largestPalindrome(_ n: Int) -> Int {
        if n == 1 { return 9 }
        let upper = Int(powf(10, Float(n))) - 1
        var cur = upper
        while cur > 0 {
            var p = cur
            var x = cur
            while x > 0 {
                p = p * 10 + x % 10
                x /= 10
            }
            var y = upper
            while y * y >= p {
                if p % y == 0 {
                    return p % 1337
                }
                y -= 1
            }
            cur -= 1
        }
        return 0
    }
    
    // MARK: - 564. 寻找最近的回文数（困难）
    /*
     给定一个表示整数的字符串 n ，返回与它最近的回文整数（不包括自身）。如果不止一个，返回较小的那个。
     “最近的”定义为两个整数差的绝对值最小。
     
     示例 1:
     输入: n = "123"
     输出: "121"
     
     999
     1001
     
     示例 2:
     输入: n = "1"
     输出: "0"
     解释: 0 和 2是最近的回文，但我们返回最小的，也就是 0。
      
     提示:
     1 <= n.length <= 18
     n 只由数字组成
     n 不含前导 0
     n 代表在 [1, 1018 - 1] 范围内的整数
     */
    static func nearestPalindromic(_ n: String) -> String {
        
        return ""
    }
    
    // MARK: - 231. 2 的幂
    /*
     给你一个整数 n，请你判断该整数是否是 2 的幂次方。如果是，返回 true ；否则，返回 false 。
     如果存在一个整数 x 使得 n == 2x ，则认为 n 是 2 的幂次方。

     示例 1：
     输入：n = 1
     输出：true
     解释：20 = 1
     
     示例 2：
     输入：n = 16
     输出：true
     解释：24 = 16
     
     示例 3：
     输入：n = 3
     输出：false
     
     示例 4：
     输入：n = 4
     输出：true
     
     示例 5：
     输入：n = 5
     输出：false
      
     提示：
     -231 <= n <= 231 - 1

     进阶：你能够不使用循环/递归解决此问题吗？
     */
    static func isPowerOfTwo(_ n: Int) -> Bool {
        /*
         // 循环
        guard n > 0 else { return false }
        var x = n
        while x % 2 == 0 {
            x = x / 2
        }
        return x == 1
        */
        // 位运算
        return n > 0 && (n & (n - 1)) == 0
    }
    
    // MARK: - 342. 4的幂
    static func isPowerOfFour(_ n: Int) -> Bool {
        // 构造偶数位全部是1的二进制：10101010
//        return n > 0 && (n & (n - 1)) == 0 && (n & 0xaaaaaaaa) == 0
        // 取余
        return n > 0 && (n & (n - 1)) == 0 && n % 3 == 1
    }
    
    // MARK: - 326. 3 的幂
    static func isPowerOfThree(_ n: Int) -> Bool {
        return n > 0 && 1162261467 % n == 0
    }
    
    // MARK: - 504. 七进制数
    /*
     给定一个整数 num，将其转化为 7 进制，并以字符串形式输出。
     
     示例 1:
     输入: num = 100
     输出: "202"
     
     示例 2:
     输入: num = -7
     输出: "-10"
      1010
     10 / 2 = 5  0
     5 / 2 = 2  1
     2 / 2 = 1 0
     1 / 2 = 0 1
     提示：
     -107 <= num <= 107
     */
    static func convertToBase7(_ num: Int) -> String {
        if num == 0 { return "0" }
        var result = ""
        var x = num
        while x != 0 {
            result.insert(Character("\(abs(x) % 7)"), at: result.startIndex)
            x /= 7
        }
        if num < 0 {
            result.insert(Character("-"), at: result.startIndex)
        }
        return  result
    }
    
    // MARK: - 263. 丑数
    /*
     丑数 就是只包含质因数 2、3 和 5 的正整数。
     给你一个整数 n ，请你判断 n 是否为 丑数 。如果是，返回 true ；否则，返回 false 。

     示例 1：
     输入：n = 6
     输出：true
     解释：6 = 2 × 3
     
     示例 2：
     输入：n = 1
     输出：true
     解释：1 没有质因数，因此它的全部质因数是 {2, 3, 5} 的空集。习惯上将其视作第一个丑数。
     
     示例 3：
     输入：n = 14
     输出：false
     解释：14 不是丑数，因为它包含了另外一个质因数 7 。
     
     提示：
     -231 <= n <= 231 - 1
     */
    static func isUgly(_ n: Int) -> Bool {
        guard n > 0 else { return false }
        var n = n
        while n % 2 == 0 {
            n /= 2
        }
        while n % 3 == 0 {
            n /= 3
        }
        while n % 5 == 0 {
            n /= 5
        }
        return n == 1
    }
    
    // MARK: - 190. 颠倒二进制位
    /*
     颠倒给定的 32 位无符号整数的二进制位。
     提示：
     请注意，在某些语言（如 Java）中，没有无符号整数类型。在这种情况下，输入和输出都将被指定为有符号整数类型，并且不应影响您的实现，因为无论整数是有符号的还是无符号的，其内部的二进制表示形式都是相同的。
     在 Java 中，编译器使用二进制补码记法来表示有符号整数。因此，在 示例 2 中，输入表示有符号整数 -3，输出表示有符号整数 -1073741825。
      
     示例 1：
     输入：n = 00000010100101000001111010011100
     输出：964176192 (00111001011110000010100101000000)
     解释：输入的二进制串 00000010100101000001111010011100 表示无符号整数 43261596，
          因此返回 964176192，其二进制表示形式为 00111001011110000010100101000000。
     
     示例 2：
     输入：n = 11111111111111111111111111111101
     输出：3221225471 (10111111111111111111111111111111)
     解释：输入的二进制串 11111111111111111111111111111101 表示无符号整数 4294967293，
          因此返回 3221225471 其二进制表示形式为 10111111111111111111111111111111 。

     提示：
     输入是一个长度为 32 的二进制字符串
     
     进阶: 如果多次调用这个函数，你将如何优化你的算法？
     */
    static func reverseBits(_ n: Int) -> Int {
        var res = 0
        for i in 0..<32 {
            res = (res << 1) + (n >> i & 1)
        }
        return res
    }
    
    // MARK: - 191. 位1的个数
    /*
     编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 '1' 的个数（也被称为汉明重量）。
     提示：
     请注意，在某些语言（如 Java）中，没有无符号整数类型。在这种情况下，输入和输出都将被指定为有符号整数类型，并且不应影响您的实现，因为无论整数是有符号的还是无符号的，其内部的二进制表示形式都是相同的。
     在 Java 中，编译器使用二进制补码记法来表示有符号整数。因此，在上面的 示例 3 中，输入表示有符号整数 -3。
      
     示例 1：
     输入：00000000000000000000000000001011
     输出：3
     解释：输入的二进制串 00000000000000000000000000001011 中，共有三位为 '1'。
     
     示例 2：
     输入：00000000000000000000000010000000
     输出：1
     解释：输入的二进制串 00000000000000000000000010000000 中，共有一位为 '1'。
     
     示例 3：
     输入：11111111111111111111111111111101
     输出：31
     解释：输入的二进制串 11111111111111111111111111111101 中，共有 31 位为 '1'。
      
     提示：
     输入必须是长度为 32 的 二进制串 。
     */
    static func hammingWeight(_ n: Int) -> Int {
        var res = 0
        var n = n
        for _ in 0..<32 {
            if n & 1 == 1 {
                res += 1
            }
            n = n >> 1
        }
        return res
    }
    
    // MARK: - 476. 数字的补数
    /*
     对整数的二进制表示取反（0 变 1 ，1 变 0）后，再转换为十进制表示，可以得到这个整数的补数。
     例如，整数 5 的二进制表示是 "101" ，取反后得到 "010" ，再转回十进制表示得到补数 2 。
     给你一个整数 num ，输出它的补数。
     
     示例 1：
     输入：num = 5
     输出：2
     解释：5 的二进制表示为 101（没有前导零位），其补数为 010。所以你需要输出 2 。
     
     示例 2：
     输入：num = 1
     输出：0
     解释：1 的二进制表示为 1（没有前导零位），其补数为 0。所以你需要输出 0 。
     
     提示：
     1 <= num < 231
     */
    static func findComplement(_ num: Int) -> Int {
        var highbit = 0
        for i in 1..<31 {
            if num >= (1 << i) {
                highbit = i
            } else {
                break
            }
        }
        let mask = highbit == 30 ? 0x7fffffff : (1 << (highbit + 1) - 1)
        return num ^ mask
    }
    
    // MARK: - 461. 汉明距离
    /*
     两个整数之间的 汉明距离 指的是这两个数字对应二进制位不同的位置的数目。
     给你两个整数 x 和 y，计算并返回它们之间的汉明距离。
     
     示例 1：
     输入：x = 1, y = 4
     输出：2
     
     解释：
     1   (0 0 0 1)
     4   (0 1 0 0)
            ↑   ↑
     上面的箭头指出了对应二进制位不同的位置。
     
     示例 2：
     输入：x = 3, y = 1
     输出：1
     
     提示：
     0 <= x, y <= 231 - 1
     */
    static func hammingDistance(_ x: Int, _ y: Int) -> Int {
        let z = x ^ y
        var res = 0
        for i in 0..<31 {
            if (z >> i) & 1 == 1 {
                res += 1
            }
        }
        return res
    }
    
    // MARK: - 477. 汉明距离总和（中等）
    /*
     两个整数的 汉明距离 指的是这两个数字的二进制数对应位不同的数量。
     给你一个整数数组 nums，请你计算并返回 nums 中任意两个数之间 汉明距离的总和 。
     
     示例 1：
     输入：nums = [4,14,2]
     输出：6
     解释：在二进制表示中，4 表示为 0100 ，14 表示为 1110 ，2表示为 0010 。（这样表示是为了体现后四位之间关系）
     所以答案为：
     HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6
     
     示例 2：
     输入：nums = [4,14,4]
     输出：4
      
     提示：
     1 <= nums.length <= 104
     0 <= nums[i] <= 109
     给定输入的对应答案符合 32-bit 整数范围
     */
    static func totalHammingDistance(_ nums: [Int]) -> Int {
        var res = 0
        let count = nums.count
        for i in 0..<30 {
            var c = 0
            for num in nums {
                c += (num >> i) & 1
            }
            res += c * (count - c)
        }
        return res
    }
    
    // MARK: - 693. 交替位二进制数
    /*
     给定一个正整数，检查它的二进制表示是否总是 0、1 交替出现：换句话说，就是二进制表示中相邻两位的数字永不相同。
     
     示例 1：
     输入：n = 5
     输出：true
     解释：5 的二进制表示是：101
     
     示例 2：
     输入：n = 7
     输出：false
     解释：7 的二进制表示是：111.
     
     示例 3：
     输入：n = 11
     输出：false
     解释：11 的二进制表示是：1011.
     */
    static func hasAlternatingBits(_ n: Int) -> Bool {
        // 除以2判断余数是否相等
        /*
        var n = n
        var pre = 2
        while n > 0 {
            if n % 2 == pre {
                return false
            }
            pre = n % 2
            n /= 2
        }
        return true
         */
        
        // 位运算
        let a = n ^ (n >> 1)
        return a & (a + 1) == 0
    }
    
    // MARK: 393. UTF-8 编码验证（中等）
    /*
     给定一个表示数据的整数数组 data ，返回它是否为有效的 UTF-8 编码。
     UTF-8 中的一个字符可能的长度为 1 到 4 字节，遵循以下的规则：
     对于 1 字节 的字符，字节的第一位设为 0 ，后面 7 位为这个符号的 unicode 码。
     对于 n 字节 的字符 (n > 1)，第一个字节的前 n 位都设为1，第 n+1 位设为 0 ，后面字节的前两位一律设为 10 。剩下的没有提及的二进制位，全部为这个符号的 unicode 码。
     这是 UTF-8 编码的工作方式：
           Number of Bytes  |        UTF-8 octet sequence
                            |              (binary)
        --------------------+---------------------------------------------
                 1          | 0xxxxxxx
                 2          | 110xxxxx 10xxxxxx
                 3          | 1110xxxx 10xxxxxx 10xxxxxx
                 4          | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
     x 表示二进制形式的一位，可以是 0 或 1。

     注意：输入是整数数组。只有每个整数的 最低 8 个有效位 用来存储数据。这意味着每个整数只表示 1 字节的数据。

     示例 1：
     输入：data = [197,130,1]
     输出：true
     解释：数据表示字节序列:11000101 10000010 00000001。
     这是有效的 utf-8 编码，为一个 2 字节字符，跟着一个 1 字节字符。
     
     11111000
     10000010
     
     示例 2：
     输入：data = [235,140,4]
     输出：false
     解释：数据表示 8 位的序列: 11101011 10001100 00000100.
     前 3 位都是 1 ，第 4 位为 0 表示它是一个 3 字节字符。
     下一个字节是开头为 10 的延续字节，这是正确的。
     但第二个延续字节不以 10 开头，所以是不符合规则的。
     
     提示:
     1 <= data.length <= 2 * 104
     0 <= data[i] <= 255
     */
    static func validUtf8(_ data: [Int]) -> Bool {
        func getByteCount(_ num: Int) -> Int? {
            var mask = 1 << 7
            if num < mask { return 1 }
            var n = 0
            while (num & mask) != 0 {
                n += 1
                if n > 4 {
                    return nil
                }
                mask = mask >> 1
            }
            return n >= 2 ? n : -1
        }
        var i = 0
        let count = data.count
        let mask = (1 << 7) | (1 << 6)
        while i < count {
            guard let byteCount = getByteCount(data[i]) else {
                return false
            }
            guard i + byteCount <= count else {
                return false
            }
            for j in i+1..<i+byteCount {
                if (data[j] & mask) != (1 << 7) {
                    return false
                }
            }
            i += byteCount
        }
        return true
    }
    
    // MARK: - 172. 阶乘后的零（中等）
    /*
     给定一个整数 n ，返回 n! 结果中尾随零的数量。
     提示 n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1
     
     示例 1：
     输入：n = 3
     输出：0
     解释：3! = 6 ，不含尾随 0
     
     示例 2：
     输入：n = 5
     输出：1
     解释：5! = 120 ，有一个尾随 0
     
     示例 3：
     输入：n = 0
     输出：0
      
     提示：
     0 <= n <= 104
      
     进阶：你可以设计并实现对数时间复杂度的算法来解决此问题吗？
     */
    static func trailingZeroes(_ n: Int) -> Int {
        var n = n
        var res = 0
        while n > 0 {
            res += n / 5
            n /= 5
        }
        return res
    }
    
    // MARK: - 458. 可怜的小猪
    /*
     有 buckets 桶液体，其中 正好有一桶 含有毒药，其余装的都是水。它们从外观看起来都一样。为了弄清楚哪只水桶含有毒药，你可以喂一些猪喝，通过观察猪是否会死进行判断。不幸的是，你只有 minutesToTest 分钟时间来确定哪桶液体是有毒的。
     喂猪的规则如下：
     选择若干活猪进行喂养
     可以允许小猪同时饮用任意数量的桶中的水，并且该过程不需要时间。
     小猪喝完水后，必须有 minutesToDie 分钟的冷却时间。在这段时间里，你只能观察，而不允许继续喂猪。
     过了 minutesToDie 分钟后，所有喝到毒药的猪都会死去，其他所有猪都会活下来。
     重复这一过程，直到时间用完。
     给你桶的数目 buckets ，minutesToDie 和 minutesToTest ，返回 在规定时间内判断哪个桶有毒所需的 最小 猪数 。
     
     示例 1：
     输入：buckets = 1000, minutesToDie = 15, minutesToTest = 60
     输出：5
     
     示例 2：
     输入：buckets = 4, minutesToDie = 15, minutesToTest = 15
     输出：2
     
     示例 3：
     输入：buckets = 4, minutesToDie = 15, minutesToTest = 30
     输出：2

     提示：
     1 <= buckets <= 1000
     1 <= minutesToDie <= minutesToTest <= 100
     */
    static func poorPigs(_ buckets: Int, _ minutesToDie: Int, _ minutesToTest: Int) -> Int {
        let states = minutesToTest / minutesToDie + 1
        return Int(ceil(log2(Double(buckets)) / log2(Double(states))))
    }
    
    // MARK: - 258.各位相加
    static func addDigits(_ num: Int) -> Int {
        // 循环
        /*
        var n = num
        while n >= 10 {
            var sum = 0
            while n > 0 {
                sum += n % 10
                n /= 10
            }
            n = sum
        }
        return n
         */
        
        // 数学
        return (num - 1) % 9 + 1
    }
    
    // MARK: - 319.灯泡开关
    static func bulbSwitch(_ n: Int) -> Int {
        return Int(sqrt(Double(n) + 0.5))
    }
    
    // MARK: - 405.数字转换为十六进制数
    /*
     给定一个整数，编写一个算法将这个数转换为十六进制数。对于负整数，我们通常使用 补码运算 方法。
     注意:
     十六进制中所有字母(a-f)都必须是小写。
     十六进制字符串中不能包含多余的前导零。如果要转化的数为0，那么以单个字符'0'来表示；对于其他情况，十六进制字符串中的第一个字符将不会是0字符。
     给定的数确保在32位有符号整数范围内。
     不能使用任何由库提供的将数字直接转换或格式化为十六进制的方法。
     
     示例 1：
     输入:
     26
     输出:
     "1a"
     
     示例 2：
     输入:
     -1
     输出:
     "ffffffff"
     */
    static func toHex(_ num: Int) -> String {
        return ""
    }
    
    // MARK: - 171. Excel 表列序号
    static func titleToNumber(_ columnTitle: String) -> Int {
        let chars = Array(columnTitle)
        let count = chars.count
        var res = 0
        for i in 0..<count {
            let num = chars[i].asciiValue! - ("A" as Character).asciiValue! + 1
            res += Int(num) * Int(powf(26, Float(count - i - 1)))
        }
        return res
    }
}
