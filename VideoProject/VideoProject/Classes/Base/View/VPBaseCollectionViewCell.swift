//
//  VPBaseCollectionViewCell.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/17.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPBaseCollectionViewCell: UICollectionViewCell {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
        setupSubviewsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() {
        
    }
    
    func setupSubviewsLayout() {
    
    }
    
}
