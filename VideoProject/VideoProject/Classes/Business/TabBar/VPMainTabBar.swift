//
//  VPMainTabBar.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPMainTabBar: UITabBar {

    //重写frame
    override var frame:CGRect{
        didSet {
            if (self.superview != nil && !(self.superview?.bounds.maxY == frame.maxY))  {
                frame.origin.y = (self.superview?.bounds.height)! - frame.height
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isTranslucent = false
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
