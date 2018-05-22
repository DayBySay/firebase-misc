//
//  ViewController.swift
//  Study-HTTPLiveStreaming
//
//  Created by 清 貴幸 on 2018/05/20.
//  Copyright © 2018年 daybysay. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let item = AVPlayerItem(url: URL(string: "http://takayuki-no-macbook.local/firebase-misc/stream/index.m3u8")!)
        let player = AVPlayer(playerItem: item)
        
        playerView.playerLayer.player = player
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class PlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
