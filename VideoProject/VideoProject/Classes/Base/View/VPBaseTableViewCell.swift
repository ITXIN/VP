//
//  VPBaseTableViewCell.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/9.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubviews()
        self.setupSubviewsLayout()
    }
    
    func initSubviews() {
        
    }
    
    func setupSubviewsLayout() {
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
