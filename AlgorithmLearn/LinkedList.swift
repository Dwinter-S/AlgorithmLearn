//
//  LinkedList.swift
//  AlgorithmLearn
//
//  Created by 苏冬冬 on 2022/7/21.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    var arr: [Int] {
        var cur: ListNode? = self
        var arr = [Int]()
        while cur != nil {
            arr.append(cur!.val)
            cur = cur!.next
        }
        return arr
    }
    init(arr: [Int]) {
        if arr.count <= 1 {
            self.next = nil
        } else {
            self.next = ListNode(arr: [Int](arr.dropFirst()))
        }
        self.val = arr.first ?? 0
    }
}

class LinkedList {
    // MARK: - 203. 移除链表元素
    /*
     给你一个链表的头节点 head 和一个整数 val ，请你删除链表中所有满足 Node.val == val 的节点，并返回 新的头节点 。
     示例 1：
     输入：head = [1,2,6,3,4,5,6], val = 6
     输出：[1,2,3,4,5]
     
     示例 2：
     输入：head = [], val = 1
     输出：[]
     
     示例 3：
     输入：head = [7,7,7,7], val = 7
     输出：[]
     
     提示：
     列表中的节点数目在范围 [0, 104] 内
     1 <= Node.val <= 50
     0 <= val <= 50
     */
    static func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        // 递归
        /*
        if head == nil { return head }
        head?.next = removeElements(head?.next, val)
        return head?.val == val ? head?.next : head
         */
        
        // 迭代
        let dummy = ListNode()
        dummy.next = head
        var pre: ListNode? = dummy
        while pre?.next != nil {
            if pre?.next?.val == val {
                pre?.next = pre?.next?.next
            } else {
                pre = pre?.next
            }
        }
        return dummy.next
    }
    
    // MARK: - 237. 删除链表中的节点
    /*
     请编写一个函数，用于 删除单链表中某个特定节点 。在设计函数时需要注意，你无法访问链表的头节点 head ，只能直接访问 要被删除的节点 。
     题目数据保证需要删除的节点 不是末尾节点 。
     
     示例 1：
     输入：head = [4,5,1,9], node = 5
     输出：[4,1,9]
     解释：指定链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9
     
     示例 2：
     输入：head = [4,5,1,9], node = 1
     输出：[4,5,9]
     解释：指定链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9
     */
    static func deleteNode(_ node: ListNode?) {
        node?.val = node!.next!.val
        node?.next = node?.next?.next
    }
    
    // MARK: - 19. 删除链表的倒数第 N 个结点 (中等 Hot 100)
    /*
     给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
     
     示例 1：
     输入：head = [1,2,3,4,5], n = 2
     输出：[1,2,3,5]
     
     示例 2：
     输入：head = [1], n = 1
     输出：[]
     
     示例 3：
     输入：head = [1,2], n = 1
     输出：[1]
     */
    static func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy = ListNode(0, head)
        var slow: ListNode? = dummy
        var fast = head
        for _ in 0..<n {
            fast = fast?.next
        }
        while fast != nil {
            slow = slow?.next
            fast = fast?.next
        }
        slow?.next = slow?.next?.next
        return dummy.next
    }
    // MARK: - 430. 删除链表中的节点（中等）
    /*
     你会得到一个双链表，其中包含的节点有一个下一个指针、一个前一个指针和一个额外的 子指针 。这个子指针可能指向一个单独的双向链表，也包含这些特殊的节点。这些子列表可以有一个或多个自己的子列表，以此类推，以生成如下面的示例所示的 多层数据结构 。
     给定链表的头节点 head ，将链表 扁平化 ，以便所有节点都出现在单层双链表中。让 curr 是一个带有子列表的节点。子列表中的节点应该出现在扁平化列表中的 curr 之后 和 curr.next 之前 。
     返回 扁平列表的 head 。列表中的节点必须将其 所有 子指针设置为 null 。
     */
    public class Node {
        public var val: Int
        public var prev: Node?
        public var next: Node?
        public var child: Node?
        public init(_ val: Int) {
            self.val = val
            self.prev = nil
            self.next = nil
            self.child  = nil
        }
    }
    
    static func flatten(_ head: Node?) -> Node? {
        func dfs(_ node: Node?) -> Node? {
            var cur = node
            // 链表最后一个节点
            var last: Node?
            while cur != nil {
                let next = cur?.next
                // 有子节点先处理子节点
                if cur?.child != nil {
                    let childLast = dfs(cur?.child)
                    // 将node与child连接
                    cur?.next = cur?.child
                    cur?.child?.prev = cur
                    // 如果next不为空，将last与next相连
                    if next != nil {
                        childLast?.next = next
                        next?.prev = childLast
                    }
                    // 将child置空
                    cur?.child = nil
                    last = childLast
                } else {
                    last = cur
                }
                cur = next
            }
           return last
        }
        dfs(head)
        return head
    }
    
    // MARK: - 61. 旋转链表（中等）
    /*
     给你一个链表的头节点 head ，旋转链表，将链表每个节点向右移动 k 个位置。
     
     示例 1：
     输入：head = [1,2,3,4,5], k = 2
     输出：[4,5,1,2,3]
     
     示例 2：
     输入：head = [0,1,2], k = 4
     输出：[2,0,1]
     
     提示：
     链表中节点的数目在范围 [0, 500] 内
     -100 <= Node.val <= 100
     0 <= k <= 2 * 109
     */
    static func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        if head == nil || head?.next == nil { return head }
        var length = 1
        var cur = head
        while cur?.next != nil {
            cur = cur?.next
            length += 1
        }
        var moveK = length - k % length
        // 首尾相连再断开
        cur?.next = head
        while moveK > 0 {
            cur = cur?.next
            moveK -= 1
        }
        let newHead = cur?.next
        cur?.next = nil
        return newHead
        // 双指针
//        let moveK = k % length
//        var slow = head
//        var fast = head
//        for _ in 0..<moveK {
//            fast = fast?.next
//        }
//        while fast?.next != nil {
//            fast = fast?.next
//            slow = slow?.next
//        }
//        fast?.next = head
//        let newHead = slow?.next
//        slow?.next = nil
//        return newHead
    }
    
    // MARK: - 24. 两两交换链表中的节点（中等）
    /*
     给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。
     
     示例 1：
     输入：head = [1,2,3,4]
     输出：[2,1,4,3]
     
     示例 2：
     输入：head = []
     输出：[]
     
     示例 3：
     输入：head = [1]
     输出：[1]
      
     提示：
     链表中节点的数目在范围 [0, 100] 内
     0 <= Node.val <= 100
     */
    static func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        let newHead = head?.next
        let thirdNode = newHead?.next
        newHead?.next = head
        head?.next = swapPairs(thirdNode)
        return newHead
        
        let dummy = ListNode(0, head)
        var cur: ListNode? = dummy
        while let first = cur?.next, let second = first.next {
            cur?.next = second
            first.next = second.next
            second.next = first
            cur = first
        }
        return dummy.next
    }
    
    // MARK: - 206. 反转链表
    /*
     给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
     
     示例 1：
     输入：head = [1,2,3,4,5]
     输出：[5,4,3,2,1]
     
     示例 2：
     输入：head = [1,2]
     输出：[2,1]
     
     示例 3：
     输入：head = []
     输出：[]
     
     提示：
     链表中节点的数目范围是 [0, 5000]
     -5000 <= Node.val <= 5000
     */
    static func reverseList(_ head: ListNode?) -> ListNode? {
        // 递归
        /*
        if head == nil || head?.next == nil { return head }
        let reverseHead = reverseList(head?.next)
        head?.next?.next = head
        head?.next = nil
        return reverseHead
         */
        // 迭代
        var pre: ListNode?
        var cur: ListNode? = head
        while cur != nil {
            // 保存next节点
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        return pre
    }
    
    // MARK: - 92. 反转链表 II（中等）
    /*
     给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。
     
     示例 1：
     输入：head = [1,2,3,4,5], left = 2, right = 4
     输出：[1,4,3,2,5] 12543
     
     示例 2：
     输入：head = [5], left = 1, right = 1
     输出：[5]
     */
    static func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        let dummy = ListNode()
        dummy.next = head
        var leftTail: ListNode? = dummy
        for _ in 0..<(left - 1) {
            leftTail = leftTail?.next
        }
        let reverseTail = leftTail?.next
        var cur = leftTail?.next
        var pre: ListNode?
        for _ in 0...(right - left) {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        leftTail?.next = pre
        reverseTail?.next = cur
        return left == 0 ? pre : dummy.next
    }
    
    // MARK: - 25. K 个一组翻转链表（困难）
    /*
     给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。
     k是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
     你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。
     
     示例 1：
     输入：head = [1,2,3,4,5], k = 2
     输出：[2,1,4,3,5]
     
     示例 2：
     输入：head = [1,2,3,4,5], k = 3
     输出：[3,2,1,4,5]
     */
    static func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        func reverseFromHead(_ head: ListNode?, k: Int) -> ListNode? {
            var pre: ListNode?
            var cur = head
            var curCount = 0
            while cur != nil, curCount < k {
                let next = cur?.next
                cur?.next = pre
                pre = cur
                cur = next
                curCount += 1
            }
            return pre
        }
        if head == nil { return head }
        var cur = head
        for _ in 0..<k {
            if cur == nil {
                return head
            }
            cur = cur?.next
        }
        let newHead = reverseFromHead(head, k: k)
        head?.next = reverseKGroup(cur, k)
        return newHead
    }
    
    // MARK: - 2. 两数相加（中等 Hot 100）
    /*
     给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
     请你将两个数相加，并以相同形式返回一个表示和的链表。
     你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

     示例 1：
     输入：l1 = [2,4,3], l2 = [5,6,4]
     输出：[7,0,8]
     解释：342 + 465 = 807.
     
     示例 2：
     输入：l1 = [0], l2 = [0]
     输出：[0]
     
     示例 3：
     输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
     输出：[8,9,9,9,0,0,0,1]
      
     提示：
     每个链表中的节点数在范围 [1, 100] 内
     0 <= Node.val <= 9
     题目数据保证列表表示的数字不含前导零
     */
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode()
        var cur: ListNode? = dummy
        var node1: ListNode? = l1
        var node2: ListNode? = l2
        var increment = 0
        while node1 != nil || node2 != nil {
            let sum = (node1?.val ?? 0) + (node2?.val ?? 0) + increment
            let node = ListNode(sum % 10)
            cur?.next = node
            cur = cur?.next
            increment = sum / 10
            node1 = node1?.next
            node2 = node2?.next
        }
        // 注意不要忘了最后的进位
        if increment == 1 {
            cur?.next = ListNode(1)
        }
        return dummy.next
    }
    
    // MARK: - 445. 两数相加 II
    /*
     给你两个 非空 链表来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储一位数字。将这两数相加会返回一个新的链表。
     你可以假设除了数字 0 之外，这两个数字都不会以零开头。
     
     示例1：
     输入：l1 = [7,2,4,3], l2 = [5,6,4]
     输出：[7,8,0,7]
     
     示例2：
     输入：l1 = [2,4,3], l2 = [5,6,4]
     输出：[8,0,7]
     
     示例3：
     输入：l1 = [0], l2 = [0]
     输出：[0]
     
     提示：
     链表的长度范围为 [1, 100]
     0 <= node.val <= 9
     输入数据保证链表代表的数字无前导 0
     
     进阶：如果输入链表不能翻转该如何解决？
     */
    static func addTwoNumbers2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 反转三次链表
        let reverseL1 = reverseList(l1)
        let reverseL2 = reverseList(l2)
        let head = addTwoNumbers(reverseL1, reverseL2)
        return reverseList(head)
        // 不反转解法：将节点放入栈中
    }
    
    // MARK: - 21. 合并两个有序链表（简单 Hot 100）
    /*
     将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
     
     示例 1：
     输入：l1 = [1,2,4], l2 = [1,3,4]
     输出：[1,1,2,3,4,4]
     
     示例 2：
     输入：l1 = [], l2 = []
     输出：[]
     
     示例 3：
     输入：l1 = [], l2 = [0]
     输出：[0]
     
     提示：
     两个链表的节点数目范围是 [0, 50]
     -100 <= Node.val <= 100
     l1 和 l2 均按 非递减顺序 排列
     */
    static func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let dummy: ListNode? = ListNode()
        var pre = dummy
        var l1 = list1
        var l2 = list2
        while l1 != nil, l2 != nil {
            if l1!.val < l2!.val {
                pre?.next = l1
                l1 = l1?.next
                
            } else {
                pre?.next = l2
                l2 = l2?.next
            }
            pre = pre?.next
        }
        if l1 != nil {
            pre?.next = l1
        }
        if l2 != nil {
            pre?.next = l2
        }
        return dummy?.next
        
        // 递归
        /*
        guard let l1 = list1 else {
            return l2
        }

        guard let l2 = list2 else {
            return l1
        }
        var mergedList: ListNode
        if l1.val < l2.val {
            mergedList = l1
            mergedList.next = mergeTwoLists(l1.next, l2)
        } else {
            mergedList = l2
            mergedList.next = mergeTwoLists(l1, l2.next)
        }
        return mergedList
         */
    }
    
    // MARK: 23. 合并K个升序链表（困难）
    /*
     给你一个链表数组，每个链表都已经按升序排列。
     请你将所有链表合并到一个升序链表中，返回合并后的链表。

     示例 1：
     输入：lists = [[1,4,5],[1,3,4],[2,6]]
     输出：[1,1,2,3,4,4,5,6]
     解释：链表数组如下：
     [
       1->4->5,
       1->3->4,
       2->6
     ]
     将它们合并到一个有序链表中得到。
     1->1->2->3->4->4->5->6
     
     示例 2：
     输入：lists = []
     输出：[]
     
     示例 3：
     输入：lists = [[]]
     输出：[]
     */
    static func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
            let dummy: ListNode? = ListNode()
            var pre = dummy
            var l1 = list1
            var l2 = list2
            while l1 != nil, l2 != nil {
                if l1!.val < l2!.val {
                    pre?.next = l1
                    l1 = l1?.next
                    
                } else {
                    pre?.next = l2
                    l2 = l2?.next
                }
                pre = pre?.next
            }
            if l1 != nil {
                pre?.next = l1
            }
            if l2 != nil {
                pre?.next = l2
            }
            return dummy?.next
        }
//        var res: ListNode?
//        for list in lists {
//            res = mergeTwoLists(res, list)
//        }
//        return res
        
        // 分治合并
        func merge(left: Int, right: Int) -> ListNode? {
            if left == right { return lists[left] }
            if left > right { return nil }
            let mid = (left + right) >> 1
            return mergeTwoLists(merge(left: left, right: mid), merge(left: mid + 1, right: right))
        }
        return merge(left: 0, right: lists.count - 1)
    }
}
