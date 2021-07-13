//
//  VPNewsVideoFullScreenViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/14.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import BMPlayer
class VPNewsVideoFullScreenViewController: VPBaseViewController {
    
    /// 播放器
    var player:BMPlayer!
    var customPlayerView:VPNewsCustomPlayerView!
    var playerBackBlock:((_ player:BMPlayer,_ currentTime:TimeInterval,_ playerView:VPNewsCustomPlayerView)->Void)?
    var curretTime:TimeInterval = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.customPlayerView.backButton.isHidden = false
        self.customPlayerView.chooseDefinitionView.isHidden = true
        self.customPlayerView.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.player.snp.makeConstraints {
            $0.edges.equalTo(self.bgView)
        }
        
        self.customPlayerView.titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(self.customPlayerView.backButton.snp.right)
            make.centerY.equalTo(self.customPlayerView.backButton)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        UIApplication.shared.statusBarOrientation = .portrait
        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        UIApplication.shared.isStatusBarHidden = false
        
        self.customPlayerView.backButton.isHidden = true
        self.customPlayerView.titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(kScreenWidth-20)
            make.top.equalTo(10)
            make.height.equalTo(20)
        }

    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        self.bgView.addSubview(self.player)
//        print("viewDidLoad",self.player.playerLayer,self.player.playerLayer?.player)
        self.customPlayerView.delegate = self
        
        self.player.snp.makeConstraints {
            $0.edges.equalTo(self.bgView)
        }
//        self.player.playTimeDidChange = {(currentTime,totalTime )in
//            VPLog(currentTime)
//            self.curretTime = currentTime
//        }
//        self.player.playStateDidChange = { (isPlaying) in
//
//            print(isPlaying)
//        }
        
        
        
    }
    
    func disMissVC() {
        self.dismiss(animated: false, completion: {
            self.player.delegate = nil
            self.customPlayerView.delegate = nil
            self.playerBackBlock?(self.player,self.curretTime,self.customPlayerView)
            
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        VPLog("viewWillTransition")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension VPNewsVideoFullScreenViewController:BMPlayerControlViewDelegate{
    func controlView(controlView: BMPlayerControlView, didChooseDefinition index: Int) {
       VPLog(index)
    }
    
    func controlView(controlView: BMPlayerControlView, didPressButton button: UIButton) {
        //这里不能实现，否则self.player.playerLayer?.player 为nill
//        controlView.player?.controlView(controlView: controlView, didPressButton: button)
        if let action = BMPlayerControlView.ButtonType(rawValue: button.tag) {
            switch action {
            case .back,.fullscreen:
              self.disMissVC()
            case .play,.pause,.replay:
                controlView.player?.controlView(controlView: controlView, didPressButton: button)
            }
        }
        
    }
    
    func controlView(controlView: BMPlayerControlView, slider: UISlider, onSliderEvent event: UIControlEvents) {
        
    }

}

extension VPNewsVideoFullScreenViewController:BMPlayerDelegate{
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        if state == .playedToTheEnd {
            self.disMissVC()
        }
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {

    }

    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {

    }

    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {

    }

    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {

    }
    
}

