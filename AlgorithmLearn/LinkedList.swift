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
