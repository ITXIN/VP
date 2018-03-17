//
//  VPShortVideoCustomPlayerView.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/17.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import BMPlayer
class VPShortVideoCustomPlayerView: BMPlayerControlView {
    override func customizeUIComponents() {
        super.customizeUIComponents()
        BMPlayerConf.topBarShowInCase = .none
        playButton.removeFromSuperview()
        currentTimeLabel.removeFromSuperview()
        totalTimeLabel.removeFromSuperview()
        timeSlider.removeFromSuperview()
        fullscreenButton.removeFromSuperview()
        progressView.removeFromSuperview()
    }
  

}