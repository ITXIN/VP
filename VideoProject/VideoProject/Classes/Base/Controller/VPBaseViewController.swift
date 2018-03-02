//
//  VPBaseViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPBaseViewController: UIViewController {
    var bgView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initSubviews()
        self.setupSubviewsLayout()
    }

    
    func initSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        
        self.bgView = {
            let view =  UIView.init()
            self.view.addSubview(view)
            return view
        }()
        
    }
    func setupSubviewsLayout() {
//        self.bgView.snp.makeConstraints { (make) in
//            make.edges.equalTo(self.view)
//        }
        self.bgView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
