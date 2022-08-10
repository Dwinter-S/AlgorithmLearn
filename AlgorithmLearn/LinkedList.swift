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
    
    // MARK: - 19. 删除链表的倒数第 N 个结点 (中等)
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
        
    }
    
    static func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let dummy: ListNode? = ListNode()
        var pre = dummy
        var l1 = list1
        var l2 = list2
        while l1 != nil, l2 != nil {
            if l1!.val < l2!.val {
                pre?.next = l1
                print("l1: \(l1?.val) \(l1?.next?.val)")
                l1 = l1?.next
                
            } else {
                pre?.next = l2
                print("l2: \(l2?.val) \(l2?.next?.val)")
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
        
//        guard let l1 = list1 else {
//            return l2
//        }
//
//        guard let l2 = list2 else {
//            return l1
//        }
//        var mergedList: ListNode
//        if l1.val < l2.val {
//            mergedList = l1
//            mergedList.next = mergeTwoLists(l1.next, l2)
//        } else {
//            mergedList = l2
//            mergedList.next = mergeTwoLists(l1, l2.next)
//        }
//
//        return mergedList
        
    }
    
}
