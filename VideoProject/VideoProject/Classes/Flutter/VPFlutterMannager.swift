//
//  VPFlutterMannager.swift
//  VideoProject
//
//  Created by liyaqing143 on 2022/5/5.
//  Copyright © 2022 icoin. All rights reserved.
//

import UIKit
import flutter_boost
import Alamofire
//class VPFlutterMannager: NSObject,FlutterPlugin {
//    static func register(with registrar: FlutterPluginRegistrar) {
//        let channel = FlutterMethodChannel(name: "flutter_channel", binaryMessenger: registrar.messenger())
//        let instance = VPFlutterMannager()
//        registrar.addMethodCallDelegate(instance, channel: channel)
//
//    }
//
//    //flutter调用原生
//    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if call.method == "flutterCalliOS" {
//            VPLog("---call.method flutterCalliOS method:\(call.method), arguments:\(call.arguments)")
//            result("ok")
//        }else{
//            VPLog("---call.method FlutterMethodNotImplemented")
//            result(FlutterMethodNotImplemented)
//        }
//    }

class VPFlutterMannager: NSObject {
    //添加自定义回调事件后获取的回调，用于在deinit中remove监听器
    var removeListener:FBVoidCallback?
    var name: String = "第一种单例" // 这是测试用的属性
    var model:VPNewsVideoModel?
    static let shared = { () -> VPFlutterMannager in
        let shared = VPFlutterMannager()
        shared.model = VPNewsVideoModel()
        shared.name = "test1"
        
//        shared.addFlutterEventListener()
        return shared
    }()
    
    private override init() {
      
    }

    //网络请求
    func addFlutterEventListener(){
        //注册自定义事件监听,回调闭包中面要用weak self，否则会有循环引用
        //removeListener->self->removeListener ,key就是forName: "event"
        VPFlutterMannager.shared.removeListener =  FlutterBoost.instance().addEventListener({ key, dic in
            //在回调中文本的值代表flutter向native传值成功
            if let data = dic?["data"] as? String{
                VPNetworkManager.loadNewsVideo(categary:"video"){ (pull, videoModelArr) in
                    if videoModelArr.count > 0{
                        var listArr = [Any]()
                        for mode in videoModelArr {
                            let json = mode?.toJSON()
                            listArr.append(json)
                        }
                        FlutterBoost.instance().sendEventToFlutter(with: key, arguments: ["data":listArr])
                    }
                }
                
            }
        }, forName: "event")
    }
    
    
    deinit {
        //解除注册，避免内存泄漏
        self.removeListener?()
    }
}
