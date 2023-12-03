//
//  Sort.swift
//  AlgorithmLearn
//
//  Created by Sven on 2023/12/4.
//

import Foundation

class Sort {
    // MARK: - 347. 前 K 个高频元素（中等 Hot 100）
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        func bucketSort(_ map: [Int : Int], k: Int) -> [Int] {
            var arr = [[Int]](), ans = [Int]()
            map.forEach { key, value in
                if arr.count < value + 1 {
                    for _ in arr.count..<value + 1 {
                        arr.append([Int]())
                    }
                }
                var cur = arr[value]
                cur.append(key)
                arr[value] = cur
            }
            for i in (0..<arr.count).reversed() {
                if arr[i].count > 0 && ans.count < k {
                    ans.append(contentsOf: arr[i])
                }
            }
            return ans
        }
        var map = [Int : Int]()
        for num in nums {
            map[num] = (map[num] ?? 0) + 1
        }
        if map.count <= k {
            return map.keys.map{ $0 }
        }
        return bucketSort(map, k: k)
    }
}
