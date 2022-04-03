//
//  VPMainViewController.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit

class VPMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initTabbarItems()
    }
    
    func initTabbarItems() {
        self.setValue(VPMainTabBar.init(), forKey: "tabBar")
        self.tabBar.backgroundImage = UIImage.getImageWithColor(color: UIColor.white,rect: CGRect.init(x: 0, y: 0, width: 1, height: 1 ))
        let navigationsArr = NSMutableArray()
        
        let imagesNormalArr = ["video_tabbar_32x32_","huoshan_tabbar_32x32_","video_tabbar_32x32_","video_tabbar_32x32_"]
        
        let imagesSeletedArr = ["video_tabbar_press_32x32_","huoshan_tabbar_press_32x32_","video_tabbar_press_32x32_","video_tabbar_press_32x32_"]
        let tabBarTitlesArr = ["西瓜视频","小视频","视频","个人中心"]
        let vcArr = [VPNewsVideoViewController(),VPShotVideoViewController(),VPMineViewController(),VPBaseViewController(),]
        for i  in 0...3 {
            let vc = vcArr[i]
            vc.title = tabBarTitlesArr[i]
            let nav =  VPBaseNavigationViewController.init(rootViewController: vc)
            let tabBarItem = UITabBarItem.init(title: tabBarTitlesArr[i], image: UIImage.init(named: imagesNormalArr[i]), selectedImage: UIImage.init(named: imagesSeletedArr[i]))
            nav.tabBarItem = tabBarItem
            nav.title = tabBarTitlesArr[i]
            
            navigationsArr.add(nav)
            
        }
        self.setViewControllers((navigationsArr as! [UIViewController]), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
