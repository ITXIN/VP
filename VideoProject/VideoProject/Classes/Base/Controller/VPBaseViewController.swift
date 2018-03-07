//
//  VPBaseViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPBaseViewController: UIViewController,UIGestureRecognizerDelegate {
    var bgView:UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        self.initSubviews()
        self.setupSubviewsLayout()
        let count:Int = (self.navigationController?.viewControllers.count)!
        if(count > 1){
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "icon_navigation_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftBarButtonBackAction))
        }
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let count:Int = (self.navigationController?.viewControllers.count)!
        if (count > 1) {
            return true
        }else{
            return false
        }

    }
    
    @objc func leftBarButtonBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initSubviews() {
        
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
    
    func popToViewController(_ controller:UIViewController) {
        for vc in (self.navigationController?.viewControllers)! {
            let kind = vc.isKind(of: VPBaseViewController.self )
            if (kind){
                self.navigationController?.popToViewController(vc, animated: true)
            }
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
