//
//  Backtracking.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class Backtracking {
    
    // MARK: - 17. 电话号码的字母组合（中等 Hot 100）
    static func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty {
            return []
        }
        var ans = [String]()
        let map = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
        
        func backtracking(_ digits: String, index: Int, s: String) {
            if index == digits.count {
                ans.append(s)
                return
            }
            let chars = Array(digits)
            let num = Int(String(chars[index]))!
            let letters = map[num]
            for i in 0..<letters.count {
                let nextS = s + String(Array(letters)[i])
                backtracking(digits, index: index + 1, s: nextS)
            }
        }
        backtracking(digits, index: 0, s: "")
        return ans
    }
    
    // MARK: - 22. 括号生成（中等 Hot 100）
    func generateParenthesis(_ n: Int) -> [String] {
        var ans = [String]()
        func backtracking(_ n: Int, _ s: String, _ left: Int, _ right: Int) {
            if left == n && right == n {
                ans.append(s)
                return
            }
            if left < n {
                backtracking(n, s + "(", left + 1, right)
            }
            if right < left {
                backtracking(n, s + ")", left, right + 1)
            }
        }
        backtracking(n, "", 0, 0)
        return ans
    }

        
    // MARK: - 79. 单词搜索（中等 Hot 100）
    static func exist(_ board: [[Character]], _ word: String) -> Bool {
        func backtracking(_ board: [[Character]], _ word: [Character], wordIndex: Int, rowIndex: Int, columnIndex: Int, visited: [[Bool]]) -> Bool {
            let rowCount = board.count
            let columnCount = board[0].count
            let curChar = Array(word)[wordIndex]
            if board[rowIndex][columnIndex] != curChar {
                return false
            }
            if wordIndex == word.count - 1 {
                return true
            }
            var visited = visited
            visited[rowIndex][columnIndex] = true
            let directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
            for direction in directions {
                let i = rowIndex + direction[0]
                let j = columnIndex + direction[1]
                if i >= 0, i < rowCount, j >= 0, j < columnCount, !visited[i][j] {
                    if backtracking(board, word, wordIndex: wordIndex + 1, rowIndex: i, columnIndex: j, visited: visited) {
                        return true
                    }
                }
            }
            visited[rowIndex][columnIndex] = false
            return false
        }
        let rowCount = board.count
        let columnCount = board[0].count
        for i in 0..<rowCount {
            for j in 0..<columnCount {
                if backtracking(board, Array(word), wordIndex: 0, rowIndex: i, columnIndex: j, visited: [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: rowCount)) {
                    return true
                }
            }
        }
        return false
    }
    
}
