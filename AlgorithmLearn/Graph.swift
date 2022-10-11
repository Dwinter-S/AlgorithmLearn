//
//  Graph.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

class Graph {
    // MARK: - 200. 岛屿数量（中等 Hot 100）
    static func numIslands(_ grid: [[Character]]) -> Int {
        // 深度优先遍历
        func dfs(_ grid: inout [[Character]], _ i: Int, _ iMax: Int, _ j: Int, _ jMax: Int) {
            guard i >= 0, i <= iMax, j >= 0, j <= jMax else {
                return
            }
            guard grid[i][j] == "1" else {
                return
            }
            grid[i][j] = "2"
            dfs(&grid, i + 1, iMax, j, jMax)
            dfs(&grid, i - 1, iMax, j, jMax)
            dfs(&grid, i, iMax, j - 1, jMax)
            dfs(&grid, i, iMax, j + 1, jMax)
        }
        
        let row = grid.count
        let column = grid[0].count
        var grid = grid
        var ans = 0
        for i in 0..<row {
            for j in 0..<column {
                if grid[i][j] == "1" {
                    dfs(&grid, i, row - 1, j, column - 1)
                    ans += 1
                }
            }
        }
        return ans
    }
}
