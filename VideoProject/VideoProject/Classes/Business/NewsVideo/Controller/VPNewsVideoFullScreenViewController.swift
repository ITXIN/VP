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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarOrientation = .landscapeRight
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        UIApplication.shared.isStatusBarHidden = true
        
        self.customPlayerView.backButton.isHidden = false
        self.customPlayerView.titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(self.customPlayerView.backButton.snp.right)
            make.centerY.equalTo(self.customPlayerView.backButton)
        }
        self.customPlayerView.isMaskShowing = true
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
        self.customPlayerView.delegate = self
        
        self.player.snp.makeConstraints {
            $0.edges.equalTo(self.bgView)
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
        
        VPLog(button)
        
        
    }
    
    func controlView(controlView: BMPlayerControlView, slider: UISlider, onSliderEvent event: UIControlEvents) {
        
    }
    
    
    
}


