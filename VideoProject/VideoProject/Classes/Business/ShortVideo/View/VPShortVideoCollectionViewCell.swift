//
//  VPShortVideoCollectionViewCell.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/17.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPShortVideoCollectionViewCell: VPBaseCollectionViewCell {
    var titleLab:UILabel!
    var diggCountLab:UILabel!
    var playCountLab:UILabel!
    var videoPreImage:UIImageView!
    var smallVideo = VPNewsVideoModel(){
        didSet{
//            titleLab.attributedText = samllVideo.raw_data.attrbutedText
            titleLab.attributedText = smallVideo.raw_data.attrbutedText
            if let largeImage = smallVideo.raw_data.large_image_list.first {
                videoPreImage.sd_setImage(with: URL(string:largeImage.urlString), completed: nil)
            }else if let firstImage = smallVideo.raw_data.first_frame_image_list.first{
                 videoPreImage.sd_setImage(with: URL(string:firstImage.urlString), completed: nil)
            }
            diggCountLab.text = smallVideo.raw_data.action.diggCount + "赞"
            playCountLab.text = smallVideo.raw_data.action.playCount + "次播放"
            
        }
    }
    
    override func initSubviews() {
        super.initSubviews()
        videoPreImage = {
            let img =  UIImageView.init()
            self.bgView.addSubview(img)
            img.contentMode = .scaleToFill
            
            return img
        }()
        titleLab = ({ () -> UILabel in
            let lab =  UILabel.init()
            self.bgView.addSubview(lab)
            lab.textColor = UIColor.white
            lab.font = UIFont.systemFont(ofSize: 15)
            lab.numberOfLines = 0
            lab.lineBreakMode = .byWordWrapping
            return lab
            }())
        diggCountLab = ({ () -> UILabel in
            let lab =  UILabel.init()
            self.bgView.addSubview(lab)
            lab.textColor = UIColor.white
            lab.font = UIFont.systemFont(ofSize: 13)
            lab.textAlignment = .right
            return lab
            }())
        playCountLab = ({ () -> UILabel in
            let lab =  UILabel.init()
            self.bgView.addSubview(lab)
            lab.textColor = UIColor.white
            lab.font = UIFont.systemFont(ofSize: 13)
            return lab
            }())
        
        
    }
    
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
        videoPreImage.snp.makeConstraints {
            $0.edges.equalTo(self.bgView)
        }

        playCountLab.snp.makeConstraints {
            $0.bottom.equalTo(-15)
            $0.left.equalTo(15)
        }
        diggCountLab.snp.makeConstraints {
            $0.right.equalTo(-15)
            $0.bottom.equalTo(-15)
        }
        titleLab.snp.makeConstraints {
            $0.bottom.equalTo(playCountLab.snp.top).offset(-10)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
        }
    }
    
    
    
    
}
