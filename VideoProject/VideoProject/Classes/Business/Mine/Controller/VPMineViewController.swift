//
//  VPMineViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/19.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import Lottie
class VPMineViewController: VPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 动画
        let headWhiteAnimation = LOTAnimationView(name: "activity_main_head_white")
        headWhiteAnimation.contentMode = .scaleAspectFill
        headWhiteAnimation.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 150)
        self.bgView.addSubview(headWhiteAnimation)
        headWhiteAnimation.play()
        headWhiteAnimation.loopAnimation = true
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
