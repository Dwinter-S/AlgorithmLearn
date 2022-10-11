//
//  Others.swift
//  AlgorithmLearn
//
//  Created by Sven on 2022/10/11.
//

import Foundation


// MARK: - 146. LRU 缓存(中等 Hot 100)
class LRUCache {

    class DLinkedNode {
        var key: Int
        var value: Int
        var pre: DLinkedNode?
        var next: DLinkedNode?
        init(key: Int, value: Int) {
            self.key = key
            self.value = value
        }
        init() {
            self.key = 0
            self.value = 0
        }
    }

    var map: [Int : DLinkedNode] = [:]
    var size: Int
    let capacity: Int
    let tail = DLinkedNode()
    let head = DLinkedNode()
    init(_ capacity: Int) {
        self.capacity = capacity
        self.size = 0
        tail.pre = head
        head.next = tail
    }
    
    func get(_ key: Int) -> Int {
        guard let node = map[key] else {
            return -1
        }
        moveToHead(node)
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = map[key] {
            node.value = value
            moveToHead(node)
        } else {
            let newNode = DLinkedNode(key: key, value: value)
            addToHead(newNode)
            map[key] = newNode
            size += 1
            if size > capacity {
                let node = removeTail()
                map[node.key] = nil
                size -= 1
            }
        }
    }

    func addToHead(_ node: DLinkedNode) {
        node.pre = head
        node.next = head.next
        head.next?.pre = node
        head.next = node
    }

    func removeNode(_ node: DLinkedNode) {
        node.pre?.next = node.next
        node.next?.pre = node.pre
    }

    func moveToHead(_ node: DLinkedNode) {
        removeNode(node)
        addToHead(node)
    }

    func removeTail() -> DLinkedNode {
        let node = tail.pre!
        removeNode(node)
        return node
    }

}


// MARK: - 155. 最小栈（中等 Hot 100）
class MinStack {
    var stack = [Int]()
    // 辅助栈
    var minStack = [Int]()
    init() {

    }
    
    func push(_ val: Int) {
        stack.append(val)
        if minStack.isEmpty {
            minStack.append(val)
        } else {
            if val < minStack.last! {
                minStack.append(val)
            } else {
                minStack.append(minStack.last!)
            }
        }
    }
    
    func pop() {
        stack.popLast()
        minStack.popLast()
    }
    
    func top() -> Int {
        return stack.last ?? 0
    }
    
    func getMin() -> Int {
        return minStack.last ?? 0
    }
}
