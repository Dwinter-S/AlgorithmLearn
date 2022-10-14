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
}
