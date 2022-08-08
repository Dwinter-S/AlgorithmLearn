//
//  ViewController.swift
//  AlgorithmLearn
//
//  Created by 苏冬冬 on 2022/7/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let list1 = ListNode(1)
        list1.next = ListNode(2)
        let list2 = ListNode(1)
        list2.next = ListNode(3)
//        print(Array.mySqrt(10))
//        print(Array.mySqrt(24))
//        print(Array.mySqrt(25))
//        print(Array.mySqrt(26))
        print(ALString.frequencySort("tree"))
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

