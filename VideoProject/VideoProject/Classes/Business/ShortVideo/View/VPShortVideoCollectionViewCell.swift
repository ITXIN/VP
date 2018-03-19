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
                videoPreImage.sd_setImage(with: URL(string:largeImage.urlString), completed:{ (image, error, type, url) in
//                    if let sdImage = image {
//                        self.sliderValueChanged(sdImage)
//                    }
                })
            }else if let firstImage = smallVideo.raw_data.first_frame_image_list.first{
                 videoPreImage.sd_setImage(with: URL(string:firstImage.urlString), completed: nil)
            }
            diggCountLab.text = smallVideo.raw_data.action.diggCount + "赞"
            playCountLab.text = smallVideo.raw_data.action.playCount + "次播放"
            
        }
    }
    func sliderValueChanged(_ sender: UIImage) {
        //获取原始图片
        let inputImage =  CIImage(image: sender)
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(1.8, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: CGSize.init(width: kScreenWidth, height: kScreenHeight))
        let context =  CIContext(options: nil)
        let cgImage = context.createCGImage(outputCIImage, from: rect)
        //显示生成的模糊图片
        videoPreImage.image = UIImage(cgImage: cgImage!)
    }
    
    override func initSubviews() {
        super.initSubviews()
        videoPreImage = {
            let img =  UIImageView.init()
            self.bgView.addSubview(img)
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true
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
    
    func setupPlayerSubviewsLayout()  {
        videoPreImage.snp.remakeConstraints {
            $0.edges.equalTo(self.bgView)
        }
    
        titleLab.snp.remakeConstraints {
            $0.top.equalTo(kStatusBarAndNavigationBarHeight+100)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
        }
        playCountLab.snp.remakeConstraints {
            $0.top.equalTo(self.titleLab.snp.bottom).offset(10)
            $0.left.equalTo(self.titleLab)
        }
        diggCountLab.snp.remakeConstraints {
            $0.left.equalTo(self.playCountLab)
            $0.top.equalTo(playCountLab.snp.bottom).offset(10)
        }
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
