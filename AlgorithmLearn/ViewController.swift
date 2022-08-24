//
//  ViewController.swift
//  AlgorithmLearn
//
//  Created by 苏冬冬 on 2022/7/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let node = ListNode(arr: [1,2,3,4,5])
        
//        print(BinarySearch.findClosestElements([1,2,3,4,5], 4, 3))
        let root = TreeNode(arr: [0,0,0,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil])
//        let root = TreeNode(arr: [1,3,2,5,3,nil,9])
        print(Tree.recoverTree(TreeNode(arr: [1,3,nil,nil,2])))
//        let item = AVPlayerItem(url: URL(string: "https://static.ieltsbro.com/uploads/app_oral_practice_comment/audio_record/1660272310666.mp3")!)
    
        
//        let item = AVPlayerItem(url: URL(string: "https://static.ieltsbro.com/uploads/app_oral_practice_comment/audio_record/1660271548144.mp3")!)
    
        let item = AVPlayerItem(url: URL(string: "https://static.ieltsbro.com/uploads/app_oral_practice_comment/audio_record/1660271474257.mp3")!)
    
        item.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: nil)
        item.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.duration), options: .new, context: nil)
        player.replaceCurrentItem(with: item)
        player.play()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
            if keyPath == #keyPath(AVPlayerItem.duration) {
                if let newDuration = change?[NSKeyValueChangeKey.newKey] as? CMTime {
                    let duration = CMTimeGetSeconds(newDuration)
//                    durationObservable.onNext(duration)
                    print("duration: \(duration)")
                }
            }
            
            if keyPath == #keyPath(AVPlayerItem.status) {
                let oldStatus: AVPlayerItem.Status
                let newStatus: AVPlayerItem.Status
                if let statusNumber = change?[.newKey] as? Int {
                    newStatus = AVPlayerItem.Status(rawValue: statusNumber)!
                } else {
                    newStatus = .unknown
                }
                if let statusNumber = change?[.oldKey] as? Int {
                    oldStatus = AVPlayerItem.Status(rawValue: statusNumber)!
                } else {
                    oldStatus = .unknown
                }
                if oldStatus != newStatus {
                    switch newStatus {
                    case .unknown: ()
                    case .readyToPlay:
                        player.play()
                    case .failed:
                        print("error")
                    default:()
                    }
                }
            }
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

