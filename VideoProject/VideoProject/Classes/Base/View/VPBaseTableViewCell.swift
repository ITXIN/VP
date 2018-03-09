//
//  VPBaseTableViewCell.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/9.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPBaseTableViewCell: UITableViewCell {

    var bgView:UIView!
    
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
        self.bgView = {
            let view =  UIView.init()
            self.contentView.addSubview(view)
            return view
        }()
    }
    func setupSubviewsLayout() {
        self.bgView.snp.makeConstraints {
            $0.edges.equalTo(self.contentView)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
