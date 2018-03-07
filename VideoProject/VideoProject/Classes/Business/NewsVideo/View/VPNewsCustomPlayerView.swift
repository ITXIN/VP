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
        BMPlayerConf.topBarShowInCase = .none
    }

}
