//
//  Tree.swift
//  AlgorithmLearn
//
//  Created by Mac mini on 2022/8/4.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Tree {
    // MARK: - 100. 相同的树
    static func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        // dfs
        if p == nil && q == nil { return true }
        let isLeftSame = isSameTree(p?.left, q?.left)
        let isRightSame = isSameTree(p?.right, q?.right)
        return isLeftSame && isRightSame && p?.val == q?.val
    }
    
    // MARK: - 222. 完全二叉树的节点个数（中等）
    static func countNodes(_ root: TreeNode?) -> Int {
        var count = 0
        var queue = [TreeNode?]()
        queue.append(root)
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            if cur == nil {
                break
            }
            queue.append(cur?.left)
            queue.append(cur?.right)
            count += 1
        }
        return count
    }
}
