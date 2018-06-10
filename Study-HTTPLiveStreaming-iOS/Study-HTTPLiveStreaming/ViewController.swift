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
    @IBOutlet weak var URLTextInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let item = AVPlayerItem(url: URL(string: "http://takayuki-no-macbook.local/firebase-misc/stream/index.m3u8")!)
    }
    
    func loadPlayerItem(item: AVPlayerItem) {
        let player = AVPlayer(playerItem: item)
        playerView.playerLayer.player = player
        player.play()
    }
    
    @IBAction func touchUpOpenButton() {
        let URLString = URLTextInput.text!
        let url = URL(string: URLString)!
        let item = AVPlayerItem(url: url)
        loadPlayerItem(item: item)
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
