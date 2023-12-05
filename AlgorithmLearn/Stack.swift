//
//  Stack.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class Stack {
    // MARK: - 739. 每日温度（中等 Hot 100）
    static func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        let n = temperatures.count
        var ans = [Int](repeating: 0, count: n)
        // 单调栈：栈底到栈顶单调递减，新元素小于栈顶元素则入栈
        var stack = [Int]()
        for i in 0..<n {
            // 栈不为空，并且当前温度大于栈顶元素
            while !stack.isEmpty && temperatures[i] > temperatures[stack.last!] {
                // 找到栈顶元素下一个更高的温度，栈顶元素出栈
                ans[stack.last!] = i - stack.last!
                stack.removeLast()
            }
            // 栈为空或者当前温度小于栈顶元素，则入栈
            stack.append(i)
        }
        return ans
    }
    
    // MARK: - 394. 字符串解码（中等 Hot 100）
    static func decodeString(_ s: String) -> String {
        var stack = [Character]()
        var chars = Array(s)
        for c in chars {
            if c != "]" {
                stack.append(c)
            } else {
                var str = ""
                while !stack.isEmpty, stack.last! != "[" {
                    str += String(stack.removeLast())
                }
                stack.removeLast()
                var countStr = ""
                while !stack.isEmpty, stack.last!.isNumber {
                    countStr += String(stack.removeLast())
                }
                let count = Int(String(countStr.reversed()))!
                let reversedStr = str.reversed()
                let repeatedStr = Array(repeating: reversedStr, count: count)
                stack.append(contentsOf: repeatedStr.flatMap({ $0 }))
            }
        }
        
        return String(stack)
    }
    
    // MARK: - 32. 最长有效括号（困难 Hot 100）
    func longestValidParentheses(_ s: String) -> Int {
        // 栈
        var ans = 0
        var stack = [-1]
        let chars = Array(s)
        for i in 0..<chars.count {
            let char = chars[i]
            if char == "(" {
                stack.append(i)
            } else {
                stack.removeLast()
                if stack.isEmpty {
                    stack.append(i)
                } else {
                    ans = max(ans, i - stack.last!)
                }
            }
        }
        return ans
    }
    
}
