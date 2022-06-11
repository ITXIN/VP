//
//  AppDelegate.swift
//  VideoProject
// 感谢GitHub原作者贡献，地址:https://github.com/hrscy/TodayNews
//  Created by ITXX on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import SVProgressHUD

import FlutterPluginRegistrant
import Flutter
import flutter_boost

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let boostDelegate = BoostDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //创建代理，做初始化操作
        FlutterBoost.instance().setup(application, delegate: boostDelegate, callback: { engine in

        })
     VPFlutterMannager.shared.addFlutterEventListener()
        self.setupAppConfiger()
        let mainVC = VPMainViewController()
        self.window?.rootViewController = mainVC
        return true
    }
   
    func setupAppConfiger() {
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setBackgroundColor(RGB(0, G: 0, B: 0))
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.black)
        if #available(iOS 11, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }else{

        }

    }
    
    func flutter_application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        //创建代理，做初始化操作
//        let delegate = BoostDelegate()
        FlutterBoost.instance().setup(application, delegate: boostDelegate, callback: { engine in
            
        })
        
        //下面开始做四个Tab页面，一个native，三个flutter
        //native主页
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "首页", image: nil, tag: 0)
         
        //下面是三个flutter vc
        let fvc1  = FBFlutterViewContainer()!
        fvc1.setName("mineTab", uniqueId: nil, params: nil, opaque: true)
        fvc1.tabBarItem = UITabBarItem(title: "flutter_tab1", image: nil, tag: 1)

        let fvc2  = FBFlutterViewContainer()!
        fvc2.setName("tab2", uniqueId: nil, params: nil, opaque: true)
        fvc2.tabBarItem = UITabBarItem(title: "flutter_tab2", image: nil, tag: 2)

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([homeViewController,fvc1,fvc2], animated: false)
       
        let navigationViewController = UINavigationController(rootViewController: tabBarController)
        navigationViewController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationViewController
        
       
        //这里将navigationController 给delegate，让delegate具有导航能力
        boostDelegate.navigationController = navigationViewController
        
        
        //在主窗口上放一个button，用来给flutter侧发送自定义事件
        let sendEventButton = UIButton()
        sendEventButton.addTarget(self, action: #selector(self.onTapSendEventButton), for:.touchUpInside)
        sendEventButton.setTitle("Send event to flutter", for: .normal)
        
        self.window?.addSubview(sendEventButton)
        
        sendEventButton.snp.makeConstraints { (mkr) in
            mkr.centerX.equalToSuperview()
            mkr.top.equalToSuperview().offset(120)
        }
        sendEventButton.backgroundColor = UIColor.red
        
        return true
    }
    
    @objc func onTapSendEventButton(){
        //发送自定义事件
        FlutterBoost.instance().sendEventToFlutter(with: "event", arguments: ["data":"event from native"])
    }
    

}


