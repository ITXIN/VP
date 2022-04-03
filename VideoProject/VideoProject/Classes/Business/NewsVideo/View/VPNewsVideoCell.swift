//
//  VPNewsVideoCell.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/9.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPNewsVideoCell: VPBaseTableViewCell {
    
    var titleLab:UILabel!
    var avatarNameLab:UILabel!
    var avatarIcon:UIButton!
    var videoPreImage:UIImageView!
    var videoPlayHudBtn:UIButton!
    var followBtn:UIButton!
    var newsVideoModel: VPNewsVideoModel? = VPNewsVideoModel(){
        didSet{
            
            titleLab.text = newsVideoModel?.title
            if let url = newsVideoModel?.user_info.avatar_url {
                avatarIcon.sd_setImage(with: URL.init(string: url), for: .normal, completed: nil)
            }
            
            if let name = newsVideoModel?.user_info.name {
                avatarNameLab.text = name
            }
            
            if let img = newsVideoModel?.video_detail_info.detail_video_large_image.urlString {
                videoPreImage.sd_setImage(with: URL.init(string: img), completed: nil)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func initSubviews() {
        super.initSubviews()
        
        self.avatarIcon = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.contentView.addSubview(btn)
            btn.layer.cornerRadius = 30/2;
            btn.layer.masksToBounds = true
            btn.backgroundColor = UIColor.vpGrayBgColor()
            return btn
        }()
        
        self.avatarNameLab = ({ () -> UILabel in
            let lab =  UILabel.init()
            self.contentView.addSubview(lab)
            lab.textColor = UIColor.vpGrayTextColor()
            lab.font = UIFont.systemFont(ofSize: 15)
            return lab
        }())
        
        self.followBtn = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.contentView.addSubview(btn)
            //            btn.layer.cornerRadius = 10
            //            btn.layer.masksToBounds = true
            //            btn.backgroundColor = UIColor.vpGrayBgColor()
            //            btn.setTitle("follow", for: .normal)
            btn.setImage(UIImage.init(named: "video_add_24x24_"), for: .normal)
            return btn
        }()
        self.videoPreImage = {
            let img =  UIImageView.init()
            self.contentView.addSubview(img)
            //            img.contentMode = .scaleToFill
            
            return img
        }()
        self.videoPlayHudBtn = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.contentView.addSubview(btn)
            btn.setBackgroundImage(UIImage.init(named: "titlebar_shadow_20x64_"), for: .normal)
            btn.setImage(UIImage.init(named: "video_play_icon_44x44_"), for: .normal)
            //            btn.layer.cornerRadius = 45/2;
            //            btn.layer.masksToBounds = true
            //            btn.backgroundColor = UIColor.vpGrayBgColor()
            return btn
        }()
        
        self.titleLab = {
            let lab =  UILabel.init()
            self.contentView.addSubview(lab)
            lab.textColor = UIColor.white
            lab.font = UIFont.boldSystemFont(ofSize: 14)
            return lab
        }()
        
    }
    
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
        
        self.avatarIcon.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(10)
            $0.size.equalTo(CGSize.init(width: 30, height: 30))
        }
        self.avatarNameLab.snp.makeConstraints {
            $0.centerY.equalTo(self.avatarIcon)
            $0.left.equalTo(self.avatarIcon.snp.right).offset(10)
        }
        self.followBtn.snp.makeConstraints {
            $0.centerY.equalTo(self.avatarNameLab)
            $0.right.equalTo(-10)
        }
        self.videoPreImage.snp.makeConstraints {
            $0.top.equalTo(self.avatarIcon.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self.contentView)
            $0.height.equalTo(187)
        }
        self.videoPlayHudBtn.snp.makeConstraints {
            $0.edges.equalTo(self.videoPreImage)
        }
        self.titleLab.snp.makeConstraints {
            $0.top.equalTo(self.videoPreImage).offset(10)
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
        }
    }
}
