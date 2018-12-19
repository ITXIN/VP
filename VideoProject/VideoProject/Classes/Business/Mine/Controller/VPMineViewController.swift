//
//  VPMineViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/19.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import Lottie
class VPMineViewController: VPBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for view  in self.bgView.subviews {
            if(view.isKind(of: LOTAnimationView.self)){
                let tem =  view as? LOTAnimationView
                tem?.play()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 动画
        let arr = ["rubberhose_to_ios","dino_dance","hearts_"]
        for index in 0..<arr.count {
            let headWhiteAnimation = LOTAnimationView(name: arr[index])
            headWhiteAnimation.contentMode = .scaleAspectFill
            
            if(index == 0){
                headWhiteAnimation.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 300)
            }else if(index == 1){
                
                danceAnimation(headWhiteAnimation)
                
            }else{
                headWhiteAnimation.frame = CGRect(x:210, y: 150, width: 100, height: 100)
            }
            self.bgView.backgroundColor = UIColor.black
            self.bgView.addSubview(headWhiteAnimation)
            headWhiteAnimation.play()
            headWhiteAnimation.loopAnimation = true
            headWhiteAnimation.tag = 100 + index
        }
        
        // Do any additional setup after loading the view.
    }
    
    func danceAnimation(_ headWhiteAnimation :LOTAnimationView){
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * 1.0 )) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            headWhiteAnimation.frame = CGRect(x: -200, y: 100, width: 200, height: 200)
            UIView.animate(withDuration: 4, animations: {
                headWhiteAnimation.frame = CGRect(x: 0, y: 100, width: 200, height: 200)
            }) { (Bool) in
                UIView.animate(withDuration: 4, animations: {
                    headWhiteAnimation.frame = CGRect(x: kScreenWidth+10, y: 100, width: 200, height: 200)
                }) { (Bool) in
                    headWhiteAnimation.frame = CGRect(x: -200, y: 100, width: 200, height: 200)
                    self.danceAnimation(headWhiteAnimation)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
