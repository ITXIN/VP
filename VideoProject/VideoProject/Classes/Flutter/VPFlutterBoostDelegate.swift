//
//  VPFlutterBoostDelegate.swift
//  VideoProject
//
//  Created by liyaqing143 on 2022/5/6.
//  Copyright © 2022 icoin. All rights reserved.
//

import UIKit
import flutter_boost

class VPFlutterBoostDelegate: NSObject,FlutterBoostDelegate {
    
    var navigationController: UINavigationController?
    
    func pushNativeRoute(_ pageName: String!, arguments: [AnyHashable : Any]!) {
        let animated:Bool = false
//        Bool(String(arguments["animated"])) ?? false
        let present:Bool = false
        let subFlutterVC: UIViewController = UIViewController()
        if present {
            self.navigationController?.present(subFlutterVC, animated: animated, completion: {
                
            })
        }else{
            self.navigationController?.pushViewController(subFlutterVC, animated: animated)
        }
        
    }
    
    func pushFlutterRoute(_ options: FlutterBoostRouteOptions!) {
        let engine = FlutterBoost.instance().engine()
        engine?.viewController = nil

        let vc =  FBFlutterViewContainer.init()
        vc?.setName(options.pageName, uniqueId: options.uniqueId, params: options.arguments, opaque: options.opaque)
        
        let animated:Bool = false
        let present:Bool = false
//        var subFlutterVC: VPFlutterViewController = VPFlutterViewController(withEntrypoint: "main")
        if present {
            self.navigationController?.present(vc!, animated: animated, completion:nil)
        }else{
            self.navigationController?.pushViewController(vc!, animated: animated)
        }
    }
    
    func popRoute(_ options: FlutterBoostRouteOptions!) {
        let vc:FBFlutterViewContainer =  self.navigationController?.presentedViewController as! FBFlutterViewContainer
        if (vc.isKind(of: FBFlutterViewContainer.self)) && (vc.uniqueId() == options.uniqueId){
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    

}


class BoostDelegate: NSObject,FlutterBoostDelegate {
    
    ///您用来push的导航栏
    var navigationController:UINavigationController?
    
    ///用来存返回flutter侧返回结果的表
    var resultTable:Dictionary<String,([AnyHashable:Any]?)->Void> = [:];
    
    func pushNativeRoute(_ pageName: String!, arguments: [AnyHashable : Any]!) {
        
        //可以用参数来控制是push还是pop
        let isPresent = arguments["isPresent"] as? Bool ?? false
        let isAnimated = arguments["isAnimated"] as? Bool ?? true
        //这里根据pageName来判断生成哪个vc，这里给个默认的了
        var targetViewController = UIViewController()
        if pageName == "homePage" {
            targetViewController = HomeViewController()
        }
        
        if(isPresent){
            self.navigationController?.present(targetViewController, animated: isAnimated, completion: nil)
        }else{
            self.navigationController?.pushViewController(targetViewController, animated: isAnimated)
        }
    }
    
    func pushFlutterRoute(_ options: FlutterBoostRouteOptions!) {
        let vc:FBFlutterViewContainer = FBFlutterViewContainer()
        vc.setName(options.pageName, uniqueId: options.uniqueId, params: options.arguments,opaque: options.opaque)
        
        //用参数来控制是push还是pop
        let isPresent = (options.arguments?["isPresent"] as? Bool)  ?? false
        let isAnimated = (options.arguments?["isAnimated"] as? Bool) ?? true
        
        //对这个页面设置结果
        resultTable[options.pageName] = options.onPageFinished;
        
        //如果是present模式 ，或者要不透明模式，那么就需要以present模式打开页面
        if(isPresent || !options.opaque){
            self.navigationController?.present(vc, animated: isAnimated, completion: nil)
        }else{
            self.navigationController?.pushViewController(vc, animated: isAnimated)
        }
    }
    
    func popRoute(_ options: FlutterBoostRouteOptions!) {
        //如果当前被present的vc是container，那么就执行dismiss逻辑
        if let vc = self.navigationController?.presentedViewController as? FBFlutterViewContainer,vc.uniqueIDString() == options.uniqueId{
            
            //这里分为两种情况，由于UIModalPresentationOverFullScreen下，生命周期显示会有问题
            //所以需要手动调用的场景，从而使下面底部的vc调用viewAppear相关逻辑
            if vc.modalPresentationStyle == .overFullScreen {
                
                //这里手动beginAppearanceTransition触发页面生命周期
                self.navigationController?.topViewController?.beginAppearanceTransition(true, animated: false)
                
                vc.dismiss(animated: true) {
                    self.navigationController?.topViewController?.endAppearanceTransition()
                }
            }else{
                //正常场景，直接dismiss
                vc.dismiss(animated: true, completion: nil)
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        //否则直接执行pop逻辑
        //这里在pop的时候将参数带出,并且从结果表中移除
        if let onPageFinshed = resultTable[options.pageName] {
            onPageFinshed(options.arguments)
            resultTable.removeValue(forKey: options.pageName)
        }
    }
}
