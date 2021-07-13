//
//  VPNewsCustomPlayerView.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/6.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import BMPlayer
class VPNewsCustomPlayerView: BMPlayerControlView {

    override func customizeUIComponents() {
        super.customizeUIComponents()
        self.backButton.isHidden = true
        self.chooseDefinitionView.isHidden = true//清晰度
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.player?.panGesture.isEnabled = false
        titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(kScreenWidth-20)
            make.top.equalTo(10)
            make.height.equalTo(20)
        }
        
    }

}
