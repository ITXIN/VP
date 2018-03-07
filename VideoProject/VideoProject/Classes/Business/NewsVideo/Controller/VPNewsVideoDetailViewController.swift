//
//  VPNewsVideoDetailViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/7.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPNewsVideoDetailViewController: VPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let testBtn:UIButton = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.bgView.addSubview(btn)
            btn.setTitle("test", for: UIControlState.normal)
            btn.setTitleColor(UIColor.red, for: UIControlState.normal)
//            btn.snp.makeConstraints {
//                $0.edges.equalTo(self.view)
//            }
            btn.snp.makeConstraints{
                $0.center.equalTo(self.bgView)
            }
            btn.addTarget(self, action:#selector(action), for: UIControlEvents.touchUpInside)
            
            return btn
        }()
    }
    @objc func action(){
        let baseVC = VPShotVideoViewController()
        self.navigationController?.pushViewController(baseVC, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftBarButtonBackAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
