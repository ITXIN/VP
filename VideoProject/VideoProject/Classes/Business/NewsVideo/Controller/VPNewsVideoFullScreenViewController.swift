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
    var playerBackBlock:((_ player:BMPlayer,_ currentTime:TimeInterval,_ playerView:BMPlayerControlView)->Void)?
    var curretTime:TimeInterval = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.customPlayerView.backButton.isHidden = false
        self.player.snp.makeConstraints {
            $0.edges.equalTo(self.bgView)
        }
        self.customPlayerView.titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(self.customPlayerView.backButton.snp.right)
            make.centerY.equalTo(self.customPlayerView.backButton)
        }
//        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        
        let num  = NSNumber.init(value: Int8(UIDeviceOrientation.landscapeLeft.rawValue))
        
        UIDevice.current.setValue(num, forKey: "orientation")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        UIApplication.shared.statusBarOrientation = .portrait
        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        UIApplication.shared.isStatusBarHidden = false
        
//        self.customPlayerView.backButton.isHidden = true
//        self.customPlayerView.titleLabel.snp.remakeConstraints { (make) in
//            make.left.equalTo(10)
//            make.width.equalTo(kScreenWidth-20)
//            make.top.equalTo(10)
//            make.height.equalTo(20)
//        }
//
//        self.customPlayerView.delegate = nil
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        self.bgView.addSubview(self.player)
        self.customPlayerView.delegate = self
        
        self.player.snp.makeConstraints {
            $0.edges.equalTo(self.bgView)
        }
        self.player.playTimeDidChange = {(currentTime,totalTime )in
            VPLog(currentTime)
            self.curretTime = currentTime
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension VPNewsVideoFullScreenViewController:BMPlayerControlViewDelegate{
    func controlView(controlView: BMPlayerControlView, didChooseDefition index: Int) {
       VPLog(index)
    }
    
    func controlView(controlView: BMPlayerControlView, didPressButton button: UIButton) {
        //先实现内部player
        controlView.player?.controlView(controlView: controlView, didPressButton: button)
        VPLog(button)
        if let action = BMPlayerControlView.ButtonType(rawValue: button.tag) {
            switch action {
            case .back,.fullscreen:
//                self.player.pause()
                playerBackBlock?(self.player,self.curretTime,self.customPlayerView)

                self.dismiss(animated: false, completion: nil)

            default:
                print("[Error] unhandled Action")
            }
        }
    
        
    }
    
    func controlView(controlView: BMPlayerControlView, slider: UISlider, onSliderEvent event: UIControlEvents) {
        
    }
    
    
    
}

