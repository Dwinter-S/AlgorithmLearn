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
    
    func getTree(arr: [Int?]) -> [[Int?]] {
        var nodes = [[Int?]]()
        var cur = 0
        var depth = 0
        let count = arr.count
        while cur < count {
            let maxCount = 1 << depth
            let addCount = count - cur > maxCount ? maxCount : count - cur
            nodes.append(Array(arr[cur..<cur + addCount]))
            depth += 1
            cur += addCount
        }
        return nodes
    }
    
    init(arr: [Int?]) {
        let node = TreeNode.getTreeNode(arr: arr, index: 0)
        self.val = node?.val ?? 0
        self.left = node?.left
        self.right = node?.right
    }
    
    static func getTreeNode(arr: [Int?], index: Int) -> TreeNode? {
        func element(at index: Int, arr: [Int?]) -> Int? {
            if index < arr.count {
                return arr[index]
            }
            return nil
        }
        if let val = element(at: index, arr: arr) {
            let node = TreeNode(val)
            if let _ = element(at: index * 2 + 1, arr: arr) {
                node.left = getTreeNode(arr: arr, index: index * 2 + 1)
            }
            if let _ = element(at: index * 2 + 2, arr: arr) {
                node.right = getTreeNode(arr: arr, index: index * 2 + 2)
            }
            return node
        }
        return nil
    }
    
}

public class Node {
    public var val: Int
    public var children: [Node]
    public init(_ val: Int) {
        self.val = val
        self.children = []
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
    
    // MARK: - 101. 对称二叉树
    /*
     给你一个二叉树的根节点 root ， 检查它是否轴对称。
     示例 1：
     输入：root = [1,2,2,3,4,4,3]
     输出：true
     
     示例 2：
     输入：root = [1,2,2,null,3,null,3]
     输出：false
     
     提示：
     树中节点数目在范围 [1, 1000] 内
     -100 <= Node.val <= 100
     
     进阶：你可以运用递归和迭代两种方法解决这个问题吗？
     */
    static func isSymmetric(_ root: TreeNode?) -> Bool {
        // 递归
        /*
        return isSymmetric(left: root?.left, right: root?.right)
        func isSymmetric(left: TreeNode?, right: TreeNode?) -> Bool {
            if left?.val != right?.val { return false }
            if left == nil && right == nil { return true }
            return isSymmetric(left: left?.right, right: right?.left) && isSymmetric(left: left?.left, right: right?.right)
        }
         */
        // 迭代
        var queue = [TreeNode?]()
        queue.append(root?.left)
        queue.append(root?.right)
        while !queue.isEmpty {
            let left = queue.removeFirst()
            let right = queue.removeFirst()
            if left?.val != right?.val {
                return false
            } else if left == nil && right == nil {
                continue
            } else {
                queue.append(left?.left)
                queue.append(right?.right)
                queue.append(left?.right)
                queue.append(right?.left)
            }
        }
        return true
    }
    
    // MARK: - 226
    static func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root?.left == nil && root?.right == nil { return root }
        let newLeft = invertTree(root?.right)
        let newRight = invertTree(root?.left)
        root?.left = newLeft
        root?.right = newRight
        return root
    }
    
    // MARK: - 437.路径总和 III（中等）
    /*
     给定一个二叉树的根节点 root ，和一个整数 targetSum ，求该二叉树里节点值之和等于 targetSum 的 路径 的数目。
     路径 不需要从根节点开始，也不需要在叶子节点结束，但是路径方向必须是向下的（只能从父节点到子节点）。
     
     示例 1：
     输入：root = [10,5,-3,3,2,null,11,3,-2,null,1], targetSum = 8
     输出：3
     解释：和等于 8 的路径有 3 条，如图所示。
     
     示例 2：
     输入：root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
     输出：3
     
     提示:
     二叉树的节点个数的范围是 [0,1000]
     -109 <= Node.val <= 109
     -1000 <= targetSum <= 1000
     */
    static func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
        // 递归
        /*
        // 以root开头的和为targetSum的数目
        func rootSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
            guard let root = root else { return 0 }
            var res = 0
            if root.val == targetSum {
                res += 1
            }
            res += rootSum(root.left, targetSum - root.val)
            res += rootSum(root.right, targetSum - root.val)
            return res
        }
        
        if root == nil { return 0 }
        var res = rootSum(root, targetSum)
        res += pathSum(root?.left, targetSum)
        res += pathSum(root?.right, targetSum)
        return res
         */
        
        // 前缀和
        var prefix = [Int : Int]()
        func dfs(root: TreeNode?, cur: Int, targetSum: Int) -> Int {
            guard let root = root else { return 0 }
            var cur = cur
            cur += root.val
            var res = 0
            if let count = prefix[cur - targetSum] {
                res = count
            }
            prefix[cur] = (prefix[cur] ?? 0) + 1
            res += dfs(root: root.left, cur: cur, targetSum: targetSum)
            res += dfs(root: root.right, cur: cur, targetSum: targetSum)
            prefix[cur] = (prefix[cur] ?? 0) - 1
            return res
        }
        prefix[0] = 1
        return dfs(root: root, cur: 0, targetSum: targetSum)
    }
    
    // MARK: - 563. 二叉树的坡度
    /*
     
     */
    static func findTilt(_ root: TreeNode?) -> Int {
        /*
        if root == nil { return 0 }
        let leftSum = rootSum(root?.left)
        let rightSum = rootSum(root?.right)
        return abs(leftSum - rightSum) + findTilt(root?.left) + findTilt(root?.right)
        func rootSum(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            return root.val + rootSum(root.left) + rootSum(root.right)
        }
         */
        var res = 0
        func dfs(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            let leftSum = dfs(root.left)
            let rightSum = dfs(root.right)
            res += abs(leftSum - rightSum)
            return root.val + leftSum + rightSum
        }
        dfs(root)
        return res
    }
    
    // MARK: - 617. 合并二叉树
    static func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        if root1 == nil {
            return root2
        }
        if root2 == nil {
            return root1
        }
        let newTree = TreeNode(root1!.val + root2!.val)
        newTree.left = mergeTrees(root1?.left, root2?.left)
        newTree.right = mergeTrees(root1?.right, root2?.right)
        return newTree
    }
    
    // MARK: - 508. 出现次数最多的子树元素和（中等）
    static func findFrequentTreeSum(_ root: TreeNode?) -> [Int] {
        var map = [Int : Int]()
        
        func dfs(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            let leftSum = dfs(root.left)
            let rightSum = dfs(root.right)
            let sum = root.val + leftSum + rightSum
            map[sum] = (map[sum] ?? 0) + 1
            return sum
        }
        dfs(root)
        var maxCount = 0
        for (_, value) in map {
            maxCount = max(maxCount, value)
        }
        return map.filter({ $0.value == maxCount }).map { $0.key }
    }
    // MARK: - 572. 另一棵树的子树
    static func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        func isSubtreeFromRoot(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
            if root == nil && subRoot == nil { return true }
            if (subRoot == nil && root != nil) || (root == nil && subRoot != nil) { return false }
            let isLeftSame = isSubtreeFromRoot(root?.left, subRoot?.left)
            let isRightSame = isSubtreeFromRoot(root?.right, subRoot?.right)
            return isLeftSame && isRightSame && root?.val == subRoot?.val
        }
        if root == nil { return false }
        let isRootSub = isSubtreeFromRoot(root, subRoot)
        return isRootSub || isSubtree(root?.left, subRoot) || isSubtree(root?.right, subRoot)
    }
    
    // MARK: - 543. 二叉树的直径
    static func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        /*
        var maxDiameter = 0
        func diameterThroughTree(_ root: TreeNode?) -> Int {
            if root == nil { return 0 }
            let cur = dfs(root?.left) + dfs(root?.right) - 2
            maxDiameter = max(maxDiameter, cur)
            diameterThroughTree(root?.left)
            diameterThroughTree(root?.right)
            return cur
        }
        
        func dfs(_ root: TreeNode?) -> Int {
            if root == nil { return 0 }
            let leftHeight = dfs(root?.left)
            let rightHeight = dfs(root?.right)
            return max(leftHeight, rightHeight) + 1
        }
        diameterThroughTree(root)
        return maxDiameter
         */
        
        var maxDiameter = 0
        func dfs(_ root: TreeNode?) -> Int {
            if root == nil { return 0 }
            let leftHeight = dfs(root?.left)
            let rightHeight = dfs(root?.right)
            maxDiameter = max(maxDiameter, leftHeight + rightHeight)
            return max(leftHeight, rightHeight) + 1
        }
        dfs(root)
        return maxDiameter
    }
    
    // MARK: - 654. 最大二叉树（中等）
    static func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        func constructMaximumBinaryTree(_ nums: [Int], left: Int, right: Int) -> TreeNode? {
            if left > right { return nil }
            let curNums = Array(nums[left...right])
            let max = curNums.max()!
            let maxIndex = nums.firstIndex(of: max)!
            let root = TreeNode(max)
            root.left = constructMaximumBinaryTree(nums, left: left, right: maxIndex - 1)
            root.right = constructMaximumBinaryTree(nums, left: maxIndex + 1, right: right)
            return root
        }
        return constructMaximumBinaryTree(nums, left: 0, right: nums.count - 1)
    }
    
    // MARK: - 687. 最长同值路径（中等）
    static func longestUnivaluePath(_ root: TreeNode?) -> Int {
        var ans = 0
        
        func dfs(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            var leftPath = dfs(root.left)
            var rightPath = dfs(root.right)
            if root.val == root.left?.val {
                leftPath += 1
            } else {
                leftPath = 0
            }
            if root.val == root.right?.val {
                rightPath += 1
            } else {
                rightPath = 0
            }
            let curPath = max(leftPath, rightPath)
            if root.val == root.left?.val && root.val == root.right?.val {
                ans = max(ans, leftPath + rightPath)
            } else {
                ans = max(ans, curPath)
            }
            return curPath
        }
        dfs(root)
        return ans
    }
    
    // MARK: - 87. 扰乱字符串（困难）
    
    // MARK: - 102. 二叉树的层序遍历（中等）
    static func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var ans = [[Int]]()
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            var arr = [Int]()
            var newNodes = [TreeNode]()
            for node in queue {
                arr.append(node.val)
                if let left = node.left {
                    newNodes.append(left)
                }
                if let right = node.right {
                    newNodes.append(right)
                }
            }
            ans.append(arr)
            queue = newNodes
        }
        return ans
    }
    
    // MARK: - 429. N 叉树的层序遍历（中等）
    static func levelOrder(_ root: Node?) -> [[Int]] {
        guard let root = root else { return [] }
        var ans = [[Int]]()
        var queue: [Node] = [root]
        while !queue.isEmpty {
            var arr = [Int]()
            var newNodes = [Node]()
            for node in queue {
                arr.append(node.val)
                for child in node.children {
                    newNodes.append(child)
                }
            }
            ans.append(arr)
            queue = newNodes
        }
        return ans
    }
    
    // MARK: - 690. 员工的重要性（中等）
    /*
     给定一个保存员工信息的数据结构，它包含了员工 唯一的 id ，重要度 和 直系下属的 id 。
     比如，员工 1 是员工 2 的领导，员工 2 是员工 3 的领导。他们相应的重要度为 15 , 10 , 5 。那么员工 1 的数据结构是 [1, 15, [2]] ，员工 2的 数据结构是 [2, 10, [3]] ，员工 3 的数据结构是 [3, 5, []] 。注意虽然员工 3 也是员工 1 的一个下属，但是由于 并不是直系 下属，因此没有体现在员工 1 的数据结构中。
     现在输入一个公司的所有员工信息，以及单个员工 id ，返回这个员工和他所有下属的重要度之和。
     
     示例：
     输入：[[1, 5, [2, 3]], [2, 3, []], [3, 3, []]], 1
     输出：11
     解释：
     员工 1 自身的重要度是 5 ，他有两个直系下属 2 和 3 ，而且 2 和 3 的重要度均为 3 。因此员工 1 的总重要度是 5 + 3 + 3 = 11 。
     
     提示：
     一个员工最多有一个 直系 领导，但是可以有多个 直系 下属
     员工数量不超过 2000 。
     */
    public class Employee {
        public var id: Int
        public var importance: Int
        public var subordinates: [Int]
        public init(_ id: Int, _ importance: Int, _ subordinates: [Int]) {
            self.id = id
            self.importance = importance
            self.subordinates = subordinates
        }
    }
    static func getImportance(_ employees: [Employee], _ id: Int) -> Int {
        guard let curEmployee = employees.first(where: { $0.id == id }) else { return 0 }
        var ans = 0
        var subordinates = curEmployee.subordinates
        while !subordinates.isEmpty {
            let subId = subordinates.removeFirst()
            let e = employees.first(where: { $0.id == subId })!
            ans += e.importance
            if !e.subordinates.isEmpty {
                subordinates.append(contentsOf: e.subordinates)
            }
        }
        return curEmployee.importance + ans
    }
    
    // MARK: - N 叉树的最大深度
    static func maxDepth(_ root: Node?) -> Int {
        guard let root = root else { return 0 }
        var ans = 1
        for child in root.children {
            ans = max(ans, maxDepth(child) + 1)
        }
        return ans
    }
    
    // MARK: - 662. 二叉树最大宽度（中等）
    static func widthOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var ans: Int = 0
        var queue = [TreeNode]()
        queue.append(root)
        root.val = 0
        while !queue.isEmpty {
            let count = queue.count
            let width = queue.last!.val - queue.first!.val + 1
            for _ in 0..<count {
                let cur = queue.removeFirst()
                if let left = cur.left {
                    queue.append(left)
                    cur.left?.val = cur.val * 2 + 1
                }
                if let right = cur.right {
                    queue.append(right)
                    cur.right?.val = cur.val * 2 + 2
                }
            }
            ans = max(ans, width)
        }
        return ans
    }
    
    // MARK: - 671. 二叉树中第二小的节点
    static func findSecondMinimumValue(_ root: TreeNode?) -> Int {
        guard let root = root else { return -1 }
        var queue: [TreeNode] = [root]
        let minValue = root.val
        var secondMinValue = Int.max
        while !queue.isEmpty {
            var curQueue = [TreeNode]()
            for node in queue {
                if let left = node.left {
                    curQueue.append(left)
                }
                if let right = node.right {
                    curQueue.append(right)
                }
                if node.val > minValue {
                    secondMinValue = min(secondMinValue, node.val)
                }
            }
            queue = curQueue
        }
        if secondMinValue != Int.max {
            return secondMinValue
        }
        return -1
    }
    
    // MARK: - 513. 找树左下角的值
    static func findBottomLeftValue(_ root: TreeNode?) -> Int {
        var queue: [TreeNode] = [root!]
        while !queue.isEmpty {
            var lineNodes = [TreeNode]()
            for node in queue {
                if let left = node.left {
                    lineNodes.append(left)
                }
                if let right = node.right {
                    lineNodes.append(right)
                }
            }
            if lineNodes.isEmpty {
                return queue.first!.val
            }
            queue = lineNodes
        }
        return 0
    }
    
    // MARK: - 515. 在每个树行中找最大值
    static func largestValues(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var queue: [TreeNode] = [root]
        
        while !queue.isEmpty {
            var lineNodes = [TreeNode]()
            var curLineMax = Int.min
            for node in queue {
                if let left = node.left {
                    lineNodes.append(left)
                }
                if let right = node.right {
                    lineNodes.append(right)
                }
                curLineMax = max(curLineMax, node.val)
            }
            ans.append(curLineMax)
            queue = lineNodes
        }
        return ans
    }
    
    // MARK: - 637. 二叉树的层平均值
    static func averageOfLevels(_ root: TreeNode?) -> [Double] {
        var ans = [Double]()
        var queue: [TreeNode] = [root!]
        while !queue.isEmpty {
            var lineNodes = [TreeNode]()
            var curLineSum = 0
            for node in queue {
                if let left = node.left {
                    lineNodes.append(left)
                }
                if let right = node.right {
                    lineNodes.append(right)
                }
                curLineSum += node.val
            }
            ans.append(Double(curLineSum) / Double(queue.count))
            queue = lineNodes
        }
        return ans
    }
    
    // MARK: - 103. 二叉树的锯齿形层序遍历（中等）
    static func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var ans = [[Int]]()
        var queue: [TreeNode] = [root]
        var isFromLeftToRight = false
        while !queue.isEmpty {
            isFromLeftToRight = !isFromLeftToRight
            var lineNodes = [TreeNode]()
            var lineValues = [Int]()
            for node in queue {
                if let left = node.left {
                    lineNodes.append(left)
                }
                if let right = node.right {
                    lineNodes.append(right)
                }
                if isFromLeftToRight {
                    lineValues.append(node.val)
                } else {
                    lineValues.insert(node.val, at: 0)
                }
            }
            ans.append(lineValues)
            queue = lineNodes
        }
        return ans
    }
    
    // MARK: - 107. 二叉树的层序遍历 II（中等）
    static func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var ans = [[Int]]()
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            var lineNodes = [TreeNode]()
            var lineValues = [Int]()
            for node in queue {
                if let left = node.left {
                    lineNodes.append(left)
                }
                if let right = node.right {
                    lineNodes.append(right)
                }
                lineValues.append(node.val)
            }
            ans.insert(lineValues, at: 0)
            queue = lineNodes
        }
        return ans
    }
    
    // MARK: 257. 二叉树的所有路径
    static func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var ans = [String]()
        func generateBinaryTreePaths(_ root: TreeNode?, paths: String) {
            guard let root = root else { return }
            var newPaths = ""
            if paths.isEmpty {
                newPaths = "\(root.val)"
            } else {
                newPaths = "\(paths)->\(root.val)"
            }
            if root.left == nil && root.right == nil {
                ans.append(newPaths)
            }
            generateBinaryTreePaths(root.left, paths: newPaths)
            generateBinaryTreePaths(root.right, paths: newPaths)
        }
        
        generateBinaryTreePaths(root, paths: "")
        return ans
    }
    
    // MARK: - 623. 在二叉树中增加一行
    static func addOneRow(_ root: TreeNode?, _ val: Int, _ depth: Int) -> TreeNode? {
        if depth == 1 {
            let newRoot = TreeNode(val)
            newRoot.left = root
            return newRoot
        }
        var queue: [TreeNode] = [root!]
        var curDepth = 1
        while !queue.isEmpty {
            var curLineNodes = [TreeNode]()
            for node in queue {
                if curDepth == depth - 1 {
                    // 到了第depth-1层，每一个节点都添加左右子节点，如果原节点有左右子节点，则拼接到新添加的节点后面
                    let newLeft = TreeNode(val)
                    if let left = node.left {
                        newLeft.left = left
                    }
                    node.left = newLeft
                    let newRight = TreeNode(val)
                    if let right = node.right {
                        newRight.right = right
                    }
                    node.right = newRight
                } else {
                    if let left = node.left {
                        curLineNodes.append(left)
                    }
                    if let right = node.right {
                        curLineNodes.append(right)
                    }
                }
            }
            curDepth += 1
            if curDepth == depth {
                break
            }
            queue = curLineNodes
        }
        return root
    }
    
    // MARK: - 653. 两数之和 IV - 输入 BST
    static func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        var arr = [Int]()
        func inorderTraversal(_ root: TreeNode?) {
            guard let root = root else { return }
            inorderTraversal(root.left)
            arr.append(root.val)
            inorderTraversal(root.right)
        }
        inorderTraversal(root)
        var left = 0
        var right = arr.count - 1
        while left < right {
            if arr[left] + arr[right] < k {
                left += 1
            } else if arr[left] + arr[right] > k {
                right -= 1
            } else {
                return true
            }
        }
        return false
    }
    
    
    // MARK: - 104. 二叉树的最大深度（简单 Hot 100）
    static func maxDepth(_ root: TreeNode?) -> Int {
        // 递归（深度优先）
        /*
        if root == nil { return 0 }
        let leftDepth = maxDepth(root?.left)
        let rightDepth = maxDepth(root?.right)
        return max(leftDepth, rightDepth) + 1
         */
        
        // 层次遍历（广度优先）
        guard let root = root else { return 0 }
        var queue = [root]
        var ans = 0
        while !queue.isEmpty {
            var count = queue.count
            while count > 0 {
                let cur = queue.removeFirst()
                if let left = cur.left {
                    queue.append(left)
                }
                if let right = cur.right {
                    queue.append(right)
                }
                count -= 1
            }
            ans += 1
        }
        return ans
    }
    
    // MARK: - 111. 二叉树的最小深度
    static func minDepth(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        let leftDepth = minDepth(root?.left)
        let rightDepth = minDepth(root?.right)
        if leftDepth == 0 {
            return rightDepth + 1
        }
        if rightDepth == 0 {
            return leftDepth + 1
        }
        return min(leftDepth, rightDepth) + 1
    }
    
    // MARK: - 112. 路径总和
    static func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        guard let root = root else { return false }
        if root.left == nil && root.right == nil && root.val == targetSum {
            return true
        }
        return hasPathSum(root.left, targetSum - root.val) || hasPathSum(root.right, targetSum - root.val)
    }
    
    // MARK: - 113. 路径总和 II
    static func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        var ans = [[Int]]()
        func dfs(_ root: TreeNode?,  _ targetSum: Int, arr: [Int]) {
            guard let root = root else { return }
            var arr = arr
            arr.append(root.val)
            if root.left == nil && root.right == nil && root.val == targetSum {
                ans.append(arr)
                return
            }
            dfs(root.left, targetSum - root.val, arr: arr)
            dfs(root.right, targetSum - root.val, arr: arr)
        }
        dfs(root, targetSum, arr: [])
        return ans
    }
    
    // MARK: - 129. 求根节点到叶节点数字之和（中等）
    static func sumNumbers(_ root: TreeNode?) -> Int {
        var sum = 0
        func dfs(_ root: TreeNode?, curSum: Int) {
            guard let root = root else { return }
            var curSum = curSum
            curSum += root.val
            if root.left == nil && root.right == nil {
                sum += curSum
                return
            }
            dfs(root.left, curSum: curSum * 10)
            dfs(root.right, curSum: curSum * 10)
        }
        dfs(root, curSum: 0)
        return sum
    }
    
    // MARK: - 404. 左叶子之和
    static func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        var sum = 0
        func traversal(_ root: TreeNode?, isLeft: Bool) {
            guard let root = root else { return }
            if isLeft, root.left == nil, root.right == nil {
                sum += root.val
            }
            traversal(root.left, isLeft: true)
            traversal(root.right, isLeft: false)
        }
        traversal(root, isLeft: false)
        return sum
    }
    
    // MARK: - 199. 二叉树的右视图（中等）
    static func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var ans = [Int]()
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            ans.append(queue.last!.val)
            var nextLineNodes = [TreeNode]()
            for node in queue {
                if let left = node.left {
                    nextLineNodes.append(left)
                }
                if let right = node.right {
                    nextLineNodes.append(right)
                }
            }
            queue = nextLineNodes
        }
        return ans
    }
    // MARK: - 655. 输出二叉树（中等）
    static func printTree(_ root: TreeNode?) -> [[String]] {
        guard let root = root else { return [] }
        func maxDepth(_ root: TreeNode?) -> Int {
            if root == nil { return 0 }
            let leftDepth = maxDepth(root?.left)
            let rightDepth = maxDepth(root?.right)
            return max(leftDepth, rightDepth) + 1
        }
        let row = maxDepth(root)
        let column = (1 << row) - 1
        var ans = [[String]](repeating: [String](repeating: "", count: column), count: row)
        var queue: [(TreeNode, Int)] = [(root, column / 2)]
        var curRow = 0
        while !queue.isEmpty {
            var nextLineNodes = [(TreeNode, Int)]()
            for node in queue {
                var diff = row - curRow - 2
                diff = 1 << diff
                if let left = node.0.left {
                    nextLineNodes.append((left, node.1 - diff))
                }
                if let right = node.0.right {
                    nextLineNodes.append((right, node.1 + diff))
                }
                ans[curRow][node.1] = "\(node.0.val)"
            }
            queue = nextLineNodes
            curRow += 1
        }
        return ans
    }
    
    // MARK: - 116. 填充每个节点的下一个右侧节点指针
    public class NodeWithNext {
        public var val: Int
        public var left: NodeWithNext?
        public var right: NodeWithNext?
        public var next: NodeWithNext?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
            self.next = nil
        }
    }
    static func connect(_ root: NodeWithNext?) -> NodeWithNext? {
        if root == nil { return root }
        var cur = root
        while cur?.left != nil {
            var head = cur
            while head != nil {
                head?.left?.next = head?.right
                head?.right?.next = head?.next?.left
                head = head?.next
            }
            cur = cur?.left
        }
        return root
    }
    
    // MARK: - 117. 填充每个节点的下一个右侧节点指针 II
    static func connect2(_ root: NodeWithNext?) -> NodeWithNext? {
        if root == nil { return root }
        var cur = root
        while cur != nil {
            var head = cur
            let dummy = NodeWithNext(0)
            var pre: NodeWithNext? = dummy
            while head != nil {
                if let left = head?.left {
                    pre?.next = left
                    pre = pre?.next
                }
                if let right = head?.right {
                    pre?.next = right
                    pre = pre?.next
                }
                head = head?.next
            }
            cur = dummy.next
        }
        return root
    }
    
    // MARK: - 144. 二叉树的前序遍历
    static func preorderTraversal(_ root: TreeNode?) -> [Int] {
        // 递归
        /*
        var ans = [Int]()
        func traversal(_ root: TreeNode?) {
            guard let root = root else { return }
            ans.append(root.val)
            traversal(root.left)
            traversal(root.right)
        }
        traversal(root)
        return ans
        */
        
        // 迭代
        guard let root = root else { return [] }
        var stack = [TreeNode]()
        stack.append(root)
        var ans = [Int]()
        while !stack.isEmpty {
            let cur = stack.removeLast()
            ans.append(cur.val)
            if let right = cur.right {
                stack.append(right)
            }
            if let left = cur.left {
                stack.append(left)
            }
        }
        return ans
    }
    
    // MAKR: - 589. N 叉树的前序遍历
    static func preorder(_ root: Node?) -> [Int] {
        // 递归
        /*
        var ans = [Int]()
        func traversal(_ root: Node?) {
            guard let root = root else { return }
            ans.append(root.val)
            for child in root.children {
                traversal(child)
            }
        }
        traversal(root)
        return ans
         */
        
        // 迭代
        guard let root = root else { return [] }
        var stack = [Node]()
        stack.append(root)
        var ans = [Int]()
        while !stack.isEmpty {
            let cur = stack.removeLast()
            ans.append(cur.val)
            for child in cur.children.reversed() {
                stack.append(child)
            }
        }
        return ans
    }
    
    // MARK: - 606. 根据二叉树创建字符串
    static func tree2str(_ root: TreeNode?) -> String {
        guard let root = root else { return "" }
        if root.left == nil && root.right == nil {
            return "\(root.val)"
        }
        if root.right == nil {
            return "\(root.val)(\(tree2str(root.left)))"
        }
        return "\(root.val)(\(tree2str(root.left)))(\(tree2str(root.right)))"
    }
    
    // MARK: - 331. 验证二叉树的前序序列化
    static func isValidSerialization(_ preorder: String) -> Bool {
        let arr = preorder.components(separatedBy: ",")
        // 代表栈中元素之和的计数器
        var slots = 1
        for i in 0..<arr.count {
            if slots == 0 {
                return false
            }
            if arr[i] == "#" {
                slots -= 1
            } else {
                slots += 1
            }
        }
        return slots == 0
    }
    
    // MAKR: - 652. 寻找重复的子树
    static func findDuplicateSubtrees(_ root: TreeNode?) -> [TreeNode?] {
        var ans = [TreeNode?]()
        var map = [String: Int]()
        @discardableResult
        func lookup(_ node: TreeNode?) -> String {
            guard let node = node else { return "#" }
            let s = "\(node.val),\(lookup(node.left)),\(lookup(node.right))"
            if map[s] == 1 {
                ans.append(node)
            }
            map[s] = (map[s] ?? 0) + 1
            return s
        }
        lookup(root)
        return ans
    }

    // MARK: - 297. 二叉树的序列化与反序列化（困难）
    static func serialize(_ root: TreeNode?) -> String {
        func toStr(_ node: TreeNode?, str: String) -> String {
            guard let node = node else { return str + "null," }
            var str = str
            str += "\(node.val),"
            str = toStr(node.left, str: str)
            str = toStr(node.right, str: str)
            return str
        }
        return toStr(root, str: "")
    }
    
    static func deserialize(_ data: String) -> TreeNode? {
        func toTree(_ data: inout [String]) -> TreeNode? {
            guard data.count > 0 else { return nil }
            if data.first == "null" {
                data.removeFirst()
                return nil
            }
            let root = TreeNode(Int(data.first!)!)
            data.removeFirst()
            root.left = toTree(&data)
            root.right = toTree(&data)
            return root
        }
        var dataArray = data.components(separatedBy: ",")
        return toTree(&dataArray)
    }
    
    // MARK: - 145. 二叉树的后序遍历
    static func postorderTraversal(_ root: TreeNode?) -> [Int] {
        // 递归
        /*
        func postorder(_ node: TreeNode?, res: inout [Int]) {
            guard let node = node else { return }
            postorder(node.left, res: &res)
            postorder(node.right, res: &res)
            res.append(node.val)
        }
        var ans = [Int]()
        postorder(root, res: &ans)
        return ans
         */
        // 迭代
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [TreeNode]()
        stack.append(root)
        while !stack.isEmpty {
            let node = stack.removeLast()
            ans.append(node.val)
            if let left = node.left {
                stack.append(left)
            }
            if let right = node.right {
                stack.append(right)
            }
        }
        return ans.reversed()
    }
    
    // MARK: - 145. 二叉树的后序遍历
    static func postorder(_ root: Node?) -> [Int] {
        func postorder(_ node: Node?, res: inout [Int]) {
            guard let node = node else { return }
            for child in node.children {
                postorder(child, res: &res)
            }
            res.append(node.val)
        }
        var ans = [Int]()
        postorder(root, res: &ans)
        return ans
    }
    
    // MARK: - 94. 二叉树的中序遍历（简单 Hot 100）
    static func inorderTraversal(_ root: TreeNode?) -> [Int] {
        // 递归
        /*
        func traversal(_ root: TreeNode?, res: inout [Int]) {
            guard let root = root else { return }
            traversal(root.left, res: &res)
            res.append(root.val)
            traversal(root.right, res: &res)
        }
        var ans = [Int]()
        traversal(root, res: &ans)
        return ans
         */
        // 迭代
        guard let root = root else { return [] }
        var ans = [Int]()
        var stack = [TreeNode]()
        var cur: TreeNode? = root
        while cur != nil || !stack.isEmpty {
            if cur != nil {
                stack.append(cur!)
                cur = cur?.left
            } else {
                let node = stack.removeLast()
                ans.append(node.val)
                cur = node.right
            }
        }
        return ans
    }
    
    // MARK: - 700. 二叉搜索树中的搜索
    static func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        // 递归
        /*
        guard let root = root else { return nil }
        if root.val < val {
            return searchBST(root.right, val)
        } else if root.val > val {
            return searchBST(root.left, val)
        }
        return root
         */
        
        // 迭代
        guard let root = root else { return nil }
        var cur: TreeNode? = root
        while cur != nil {
            if cur!.val > val {
                cur = cur?.left
            } else if cur!.val < val {
                cur = cur?.right
            } else {
                return cur
            }
        }
        return nil
    }
    
    // MARK: - 530. 二叉搜索树的最小绝对差
    static func getMinimumDifference(_ root: TreeNode?) -> Int {
        var ans = Int.max
        var pre: Int?
        func traversal(_ node: TreeNode?) {
            guard let node = node else { return }
            traversal(node.left)
            if pre != nil {
                ans = min(ans, node.val - pre!)
            }
            pre = node.val
            traversal(node.right)
        }
        traversal(root)
        return ans
    }
    
    // MARK: - 538. 把二叉搜索树转换为累加树（中等）
    static func convertBST(_ root: TreeNode?) -> TreeNode? {
        /*
        var sum = 0
        func convert(_ root: TreeNode?) {
            if root != nil {
                convert(root?.right)
                sum += root!.val
                convert(root?.left)
            }
        }
        convert(root)
        return root
         */
        func dfs(_ root: TreeNode?, parentVal: Int) -> Int {
            guard let root = root else { return parentVal }
            root.val += dfs(root.right, parentVal: parentVal)
            return dfs(root.left, parentVal: root.val)
        }
        dfs(root, parentVal: 0)
        return root
    }
    
    // MARK: - 230. 二叉搜索树中第K小的元素（中等）
    static func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        guard let root = root else { return 0 }
        var stack = [root]
        var cur: TreeNode? = root
        var k = k
        while cur != nil || !stack.isEmpty {
            if cur != nil {
                stack.append(cur!)
                cur = cur?.left
            } else {
                let node = stack.removeLast()
                k -= 1
                if k == 0 {
                    return node.val
                }
                cur = node.right
            }
        }
        return root.val
    }
    
    // MARK: - 98. 验证二叉搜索树
    static func isValidBST(_ root: TreeNode?) -> Bool {
        func isValidBST(_ root: TreeNode?, min: Int?, max: Int?) -> Bool {
            guard let root = root else { return true }
            if let min = min, root.val <= min { return false }
            if let max = max, root.val >= max { return false }
            return isValidBST(root.left, min: min, max: root.val) && isValidBST(root.right, min: root.val, max: max)
        }
        return isValidBST(root, min: nil, max: nil)
    }
    
    // MARK: - 173. 二叉搜索树迭代器
    /*
    class Intearal {
        init(_ root: TreeNode?) {
            
        }
        
        func next() -> Int {
            
        }
        
        func hasNext() -> Bool {
            
        }
    }
     */
    
    // MARK: - 669. 修剪二叉搜索树
    static func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
        guard let root = root else { return nil }
        let trimLeft = trimBST(root.left, low, high)
        let trimRight = trimBST(root.right, low, high)
        if root.val > high {
            return trimLeft
        } else if root.val < low {
            return trimRight
        }
        root.left = trimLeft
        root.right = trimRight
        return root
    }
    
    // MARK: - 450. 删除二叉搜索树中的节点
    static func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
//        guard let root = root else { return nil }
//        if root.left == nil && root.right == nil && root.val == key { return nil }
//        var cur: TreeNode? = root
//        var delParentNode: TreeNode?
//        while cur != nil {
//            if cur!.val > key {
//                cur = cur?.left
//            } else if cur!.val < key {
//                cur = cur?.right
//            } else {
//                break
//            }
//            delParentNode = cur
//        }
//        guard let cur = cur else { return nil }
//        var replaceNodeParentNode: TreeNode = cur
//        if let left = cur.left {
//            var leftMaxNode: TreeNode = left
//            while leftMaxNode.right != nil {
//                leftMaxNode = leftMaxNode.right!
//            }
//            cur.val = leftMaxNode.val
//        } else if let right = cur.right {
//
//        } else {
//            delParentNode
//        }
//        return root
        
        guard let root = root else { return nil }
        if root.val > key {
            root.left = deleteNode(root.left, key)
        } else if root.val < key {
            root.right = deleteNode(root.right, key)
        } else {
            if root.left == nil && root.right == nil {
                return nil
            }
            if root.right == nil {
                return root.left
            }
            if root.left == nil {
                return root.right
            }
            // 找到删除节点右子树的最小节点当做新的根节点
            var newRoot: TreeNode? = root.right
            while newRoot?.left != nil {
                newRoot = newRoot?.left
            }
            // 删除右子树的最小节点
            root.right = deleteNode(root.right, newRoot!.val)
            // 将原左右子树拼接到新节点上
            newRoot?.right = root.right
            newRoot?.left = root.left
            return newRoot
        }
        return root
    }
    
    // MARK: - 110. 平衡二叉树
    static func isBalanced(_ root: TreeNode?) -> Bool {
        /*
        func height(_ root: TreeNode?) -> Int {
            if root == nil { return 0 }
            return max(height(root?.left), height(root?.right)) + 1
        }
        guard let root = root else { return true }
        let isRootBalanced = abs(height(root.left) - height(root.right)) <= 1
        return isRootBalanced && isBalanced(root.left) && isBalanced(root.right)
         */
        
        func height(_ root: TreeNode?) -> Int {
            if root == nil { return 0 }
            let leftHeight = height(root?.left)
            if leftHeight == -1 { return -1 }
            let rightHeight = height(root?.right)
            if rightHeight == -1 { return -1 }
            return abs(leftHeight - rightHeight) > 1 ? -1 : max(leftHeight, rightHeight) + 1
        }
        return height(root) >= 0 ? true : false
    }
    
    // MARK: - 95. 不同的二叉搜索树 II
    static func generateTrees(_ n: Int) -> [TreeNode?] {
        func generateTrees(start: Int, end: Int) -> [TreeNode?] {
            if start > end { return [nil] }
            var allTrees = [TreeNode?]()
            for i in start...end {
                let leftTrees = generateTrees(start: start, end: i - 1)
                let rightTrees = generateTrees(start: i + 1, end: end)
                for left in leftTrees {
                    for right in rightTrees {
                        let root = TreeNode(i)
                        root.left = left
                        root.right = right
                        allTrees.append(root)
                    }
                }
            }
            return allTrees
        }
        return generateTrees(start: 1, end: n)
    }
    
    // MARK: - 108. 将有序数组转换为二叉搜索树
    static func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        func generateBST(_ nums: [Int], start: Int, end: Int) -> TreeNode? {
            if start > end {
                return nil
            }
            let mid = start + (end - start) / 2
            let node = TreeNode(nums[mid])
            node.left = generateBST(nums, start: start, end: mid - 1)
            node.right = generateBST(nums, start: mid + 1, end: end)
            return node
        }
        return generateBST(nums, start: 0, end: nums.count - 1)
    }
    
    // MARK: - 109. 有序链表转换二叉搜索树
    static func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        guard let head = head else { return nil }
        guard head.next != nil else { return TreeNode(head.val) }
        var slow: ListNode? = head
        var fast: ListNode? = head
        var pre: ListNode? = head
        while fast?.next?.next != nil {
            fast = fast?.next?.next
            pre = slow
            slow = slow?.next
        }
        let next = slow?.next
        pre?.next = nil
        let node = TreeNode(slow!.val)
        if slow?.val == fast?.val {
            node.left = nil
        } else {
            node.left = sortedListToBST(head)
        }
        node.right = sortedListToBST(next)
        return node
    }
    
    // MARK: - 105. 从前序与中序遍历序列构造二叉树（中等）
    static func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        var varIndexMap = [Int : Int]()
        func buildTree(_ preorder: [Int], preStart: Int, preEnd: Int,
                       _ inorder: [Int], inStart: Int, inEnd: Int) -> TreeNode? {
            if preStart > preEnd { return nil }
            let inRootVal = preorder[preStart]
            let inRootIndex = varIndexMap[inRootVal]!
            let leftSize = inRootIndex - inStart
            let node = TreeNode(inRootVal)
            node.left = buildTree(preorder, preStart: preStart + 1, preEnd: preStart + leftSize, inorder, inStart: inStart, inEnd: inRootIndex - 1)
            node.right = buildTree(preorder, preStart: preStart + leftSize + 1, preEnd: preEnd, inorder, inStart: inRootIndex + 1, inEnd: inEnd)
            return node
        }
        for (index, val) in inorder.enumerated() {
            varIndexMap[val] = index
        }
        return buildTree(preorder, preStart: 0, preEnd: preorder.count - 1, inorder, inStart: 0, inEnd: inorder.count - 1)
    }
    
    // MARK: - 106. 从中序与后序遍历序列构造二叉树（中等）
    static func buildTree2(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        var varIndexMap = [Int : Int]()
        func buildTree2(_ inorder: [Int], inStart: Int, inEnd: Int,
                       _ postorder: [Int], postStart: Int, postEnd: Int) -> TreeNode? {
            if postStart > postEnd { return nil }
            let inRootVal = postorder[postEnd]
            let inRootIndex = varIndexMap[inRootVal]!
            let leftSize = inRootIndex - inStart
            let node = TreeNode(inRootVal)
            node.left = buildTree2(inorder, inStart: inStart, inEnd: inRootIndex - 1, postorder, postStart: postStart, postEnd: postStart + leftSize - 1)
            node.right = buildTree2(inorder, inStart: inRootIndex + 1, inEnd: inEnd, postorder, postStart: postStart + leftSize, postEnd: postEnd - 1)
            return node
        }
        for (index, val) in inorder.enumerated() {
            varIndexMap[val] = index
        }
        return buildTree2(inorder, inStart: 0, inEnd: inorder.count - 1, postorder, postStart: 0, postEnd: postorder.count - 1)
    }
    
    // MARK: - 114. 二叉树展开为链表（中等）
    static func flatten(_ root: TreeNode?) {
        var cur = root
        while cur != nil {
            if let left = cur?.left {
                var pre: TreeNode? = left
                while pre?.right != nil {
                    pre = pre?.right
                }
                pre?.right = cur?.right
                cur?.right = cur?.left
                cur?.left = nil
            }
            cur = cur?.right
        }
    }
    
    // MARK: - 235. 二叉搜索树的最近公共祖先
    static func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        // 递归
        /*
        guard let root = root else { return nil }
        guard let p = p else { return q }
        guard let q = q else { return p }
        if q.val > root.val && p.val > root.val {
            return lowestCommonAncestor(root.right, p, q)
        }
        if q.val < root.val && p.val < root.val {
            return lowestCommonAncestor(root.left, p, q)
        }
        return root
         */
        guard let root = root else { return nil }
        guard let p = p else { return q }
        guard let q = q else { return p }
        var ans: TreeNode = root
        while true {
            if q.val > ans.val && p.val > ans.val {
                ans = ans.right!
            } else if q.val < ans.val && p.val < ans.val {
                ans = ans.left!
            } else {
                break
            }
        }
        return ans
    }
    
    // MARK: - 236. 二叉树的最近公共祖先
    static func lowestCommonAncestor2(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        guard let p = p else { return q }
        guard let q = q else { return p }
        if root.val == p.val || root.val == q.val { return root }
        
        let left = lowestCommonAncestor(root.left, p, q)
        let right = lowestCommonAncestor(root.right, p, q)
        
        if left == nil && right != nil { return right }
        if left != nil && right == nil { return left }
        if left != nil && right != nil { return root }
        return nil
    }
    
    // MARK: - 501. 二叉搜索树中的众数
    static func findMode(_ root: TreeNode?) -> [Int] {
        var ans = [Int]()
        var maxCount = 0
        var curCount = 0
        var preVal = Int.min
        
        func traversal(_ root: TreeNode?) {
            guard let root = root else { return }
            traversal(root.left)
            if preVal == root.val {
                curCount += 1
            } else {
                curCount = 1
                preVal = root.val
            }
            if curCount > maxCount {
                ans = [root.val]
                maxCount = curCount
            } else if curCount == maxCount {
                ans.append(root.val)
            }
            
            traversal(root.right)
        }
        traversal(root)
        return ans
    }
    
    // MARK: - 99. 恢复二叉搜索树
    static func recoverTree(_ root: TreeNode?) {
        guard let root = root else { return }
        var stack = [TreeNode]()
        var cur: TreeNode? = root
        var pre: TreeNode?
        var x: TreeNode?
        var y: TreeNode?
        while cur != nil || !stack.isEmpty {
            if cur != nil {
                stack.append(cur!)
                cur = cur?.left
            } else {
                let node = stack.removeLast()
                if pre != nil, node.val < pre!.val {
                    y = node
                    if x == nil {
                        x = pre
                    } else {
                        break
                    }
                }
                pre = node
                cur = node.right
            }
        }
        if x != nil && y != nil {
            let temp = x!.val
            x?.val = y!.val
            y?.val = temp
        }
    }
    
    // MARK: - 208. 实现 Trie (前缀树)（中等 Hot 100）
    class Trie {
        var children: [Trie?]
        var isEnd: Bool
        init() {
            children = [Trie?](repeating: nil, count: 26)
            isEnd = false
        }
        
        func insert(_ word: String) {
            let chars = Array(word)
            var node: Trie = self
            for char in chars {
                let index = Int(char.asciiValue! - Character("a").asciiValue!)
                if node.children[index] == nil {
                    node.children[index] = Trie()
                }
                node = node.children[index]!
            }
            node.isEnd = true
        }
        
        func search(_ word: String) -> Bool {
            let node = searchPreix(word)
            return node != nil && node!.isEnd
        }
        
        func searchPreix(_ word: String) -> Trie? {
            let chars = Array(word)
            var node: Trie = self
            for char in chars {
                let index = Int(char.asciiValue! - Character("a").asciiValue!)
                if node.children[index] == nil {
                    return nil
                }
                node = node.children[index]!
            }
            return node
        }
        
        func startsWith(_ prefix: String) -> Bool {
            return searchPreix(prefix) != nil
        }
    }
}
