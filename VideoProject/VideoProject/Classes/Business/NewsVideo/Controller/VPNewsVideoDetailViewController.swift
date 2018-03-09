//
//  VPNewsVideoDetailViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/7.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class VPNewsVideoDetailViewController: VPBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let _:UIButton = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.bgView.addSubview(btn)
            btn.setImage(UIImage.init(named: "icon_navigation_back"), for: .normal)
            btn.backgroundColor = UIColor.red
            btn.layer.cornerRadius = 30/2
            btn.layer.masksToBounds = true
            btn.snp.makeConstraints{
                $0.left.equalTo(10)
                $0.top.equalTo(kStatusBarHeight)
                $0.size.equalTo(CGSize.init(width: 30, height: 30))
            }
            
            btn.addTarget(self, action:#selector(action), for: UIControlEvents.touchUpInside)
            
//            let dis = DisposeBag()
//            btn.rx.tap
//                .subscribe(onNext: { [weak self] in
//                    self?.dismiss(animated: true, completion: nil)
//                })
//                .disposed(by:dis )
            btn.rx.tap.subscribe({_ in
                self.dismiss(animated: true, completion: nil)
            }).dispose()
            return btn
        }()
    }
    
    @objc func action(){
//        let baseVC = VPShotVideoViewController()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftBarButtonBackAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
