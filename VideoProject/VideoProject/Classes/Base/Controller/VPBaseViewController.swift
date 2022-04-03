//
//  VPBaseViewController.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import MJRefresh
typealias VPRefreshComponentRefreshingBlock = ()->Void

class VPBaseViewController: UIViewController,UIGestureRecognizerDelegate {
    
    public var _headerRefreshingBlock:VPRefreshComponentRefreshingBlock?
    public var _footerRefreshingBlock:VPRefreshComponentRefreshingBlock?
    public var header: VPRefreshGifHeader!
    public var footer: MJRefreshAutoNormalFooter!
    public var dataArr:NSMutableArray!
    
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
        if ((self.navigationController?.viewControllers) != nil) {
            let count:Int = (self.navigationController?.viewControllers.count)!
            if(count > 1){
                self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "icon_navigation_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftBarButtonBackAction))
            }
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
        
    }
    
    func setupSubviewsLayout() {
        
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
    
}
