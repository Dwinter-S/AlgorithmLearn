//
//  BitManipulation.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class BitManipulation {
    
    // 338. 比特位计数（简单 Hot 100）
    static func countBits(_ n: Int) -> [Int] {
        var ans = [Int](repeating: 0, count: n + 1)
        // i & (i - 1): 清零最低位的1
        for i in 1...n {
            ans[i] += ans[i & (i - 1)] + 1
        }
        return ans
    }
    
}


