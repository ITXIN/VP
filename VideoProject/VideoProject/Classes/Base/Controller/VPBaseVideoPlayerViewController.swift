//
//  VPBaseVideoPlayerViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/16.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import BMPlayer
class VPBaseVideoPlayerViewController: VPBaseViewController {

    var newsVideoModelArr = [VPNewsVideoModel]()
    var customPlayerView = VPNewsCustomPlayerView()
    var categary = "video"
    /// 播放器
    lazy var player: BMPlayer = BMPlayer(customControlView: customPlayerView)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //删除播放器
    func removePlayer() {
        self.player.pause()
        self.player.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
