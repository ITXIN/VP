//
//  VPNewsVideoCell.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/9.
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
    var newsVideoModel = VPNewsVideoModel(){
        didSet{
            titleLab.text = newsVideoModel.title
            avatarIcon.sd_setImage(with: URL.init(string: newsVideoModel.user_info.avatar_url), for: .normal, completed: nil)
            avatarNameLab.text = newsVideoModel.user_info.name
            videoPreImage.sd_setImage(with: URL.init(string: newsVideoModel.video_detail_info.detail_video_large_image.urlString), completed: nil)
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
        self.videoPreImage = {
            let img =  UIImageView.init()
            self.bgView.addSubview(img)
            img.contentMode = .scaleToFill
            img.backgroundColor = UIColor.yellow
            return img
        }()
        self.videoPlayHudBtn = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.bgView.addSubview(btn)
            btn.setBackgroundImage(UIImage.init(named: "titlebar_shadow_20x64_"), for: .normal)
            btn.setImage(UIImage.init(named: "video_play_icon_44x44_"), for: .normal)
//            btn.layer.cornerRadius = 45/2;
//            btn.layer.masksToBounds = true
//            btn.backgroundColor = UIColor.vpGrayBgColor()
            return btn
        }()
        self.titleLab = ({ () -> UILabel in
            let lab =  UILabel.init()
            self.bgView.addSubview(lab)
            lab.textColor = UIColor.white
            lab.font = UIFont.systemFont(ofSize: 14)
            return lab
            }())
        
        self.avatarIcon = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.bgView.addSubview(btn)
            btn.layer.cornerRadius = 45/2;
            btn.layer.masksToBounds = true
            btn.backgroundColor = UIColor.vpGrayBgColor()
            return btn
        }()
        
        self.avatarNameLab = ({ () -> UILabel in
            let lab =  UILabel.init()
            self.bgView.addSubview(lab)
            lab.textColor = UIColor.vpGrayTextColor()
            lab.font = UIFont.systemFont(ofSize: 13)
            return lab
            }())
        
        self.followBtn = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.bgView.addSubview(btn)
//            btn.layer.cornerRadius = 10
//            btn.layer.masksToBounds = true
//            btn.backgroundColor = UIColor.vpGrayBgColor()
//            btn.setTitle("follow", for: .normal)
            btn.setImage(UIImage.init(named: "video_add_24x24_"), for: .normal)
            return btn
        }()
        
    }
    
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
        self.videoPreImage.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.trailing.equalTo(self.bgView)
            $0.height.equalTo(187)
        }
        self.videoPlayHudBtn.snp.makeConstraints {
            $0.edges.equalTo(self.videoPreImage)
        }
        self.titleLab.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
        }
        self.avatarIcon.snp.makeConstraints {
            $0.bottom.equalTo(-50)
            $0.left.equalTo(10)
            $0.size.equalTo(CGSize.init(width: 45, height: 45))
        }
        self.avatarNameLab.snp.makeConstraints {
            $0.top.equalTo(self.avatarIcon.snp.bottom).offset(10)
            $0.left.equalTo(self.avatarIcon)
        }
        self.followBtn.snp.makeConstraints {
            $0.centerY.equalTo(self.avatarNameLab)
            $0.right.equalTo(-10)
        }
    }
}
