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
    
    // MARK: - 207. 课程表（中等 Top 100）
    static func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        // 深度优先搜索
        func dfs(u: Int) {
            // 标记为搜索中
            visited[u] = 1
            for v in edges[u] {
                if visited[v] == 0 {
                    dfs(u: v)
                    if !isValid {
                        return
                    }
                } else if visited[v] == 1 {
                    // 发现环
                    isValid = false
                    return
                }
            }
            // 标记为搜索完成
            visited[u] = 2
        }
        // 存放每个节点相邻节点数组
        var edges = [[Int]]()
        // 搜索状态数组（0：未搜索 1：搜索中 2：已完成）
        var visited = [Int]()
        var isValid = true
        for _ in 0..<numCourses {
            edges.append([Int]())
            visited.append(0)
        }
        for info in prerequisites {
            var pre = edges[info[1]]
            pre.append(info[0])
            edges[info[1]] = pre
        }
        for i in 0..<numCourses {
            if !isValid {
                break
            }
            if visited[i] == 0 {
                dfs(u: i)
            }
        }
        return isValid
    }
}
