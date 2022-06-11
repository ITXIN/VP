////
////  VPFlutterViewController.swift
////  VideoProject
////
////  Created by liyaqing143 on 2022/4/29.
////  Copyright © 2022 icoin. All rights reserved.
////
//
//import UIKit
////import Flutter
////import FlutterPluginRegistrant
////参考： http://events.jianshu.io/p/8294bc7e7004
////class VPFlutterViewController: FlutterViewController {
////
////    init(withEntrypoint entrypoint: String?) {
////        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
////        let newEngine = appDelegate.engineGroup.makeEngine(withEntrypoint: entrypoint, libraryURI: nil)
////
////        VPFlutterMannager.register(with: newEngine.registrar(forPlugin: "VPFlutterMannager")!)
////        super.init(engine: newEngine, nibName: nil, bundle: nil)
////    }
////
////    required convenience init(coder aDecoder: NSCoder) {
////        self.init(withEntrypoint:nil)
////    }
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        //如果在Flutter module中用了插件来实现的，我们需要把插件统一注册到Flutter Engine中，修改如下
////        GeneratedPluginRegistrant.register(with: self.pluginRegistry())
////    }
//}
