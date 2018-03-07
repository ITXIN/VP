//
//  AppHeader.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh
import BMPlayer
/*
 * 增加宏定义NSLog输出函数
 */
func LPLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))****\(messsage)")
    #else  //发布阶段
        print(...)
    #endif
    
    
}


let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

func RGBA(_ R:CGFloat/*红*/, G:CGFloat/*绿*/, B:CGFloat/*蓝*/, A:CGFloat/*透明*/)->UIColor {
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}
func RGB(_ R:CGFloat/*红*/, G:CGFloat/*绿*/, B:CGFloat/*蓝*/)->UIColor {
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1)
}

let kiPhoneX    =    (kScreenHeight == 812.0 &&  kScreenWidth == 375.0)


// Status bar height.
let  kStatusBarHeight  =    (kiPhoneX ? 44.0 : 20.0)

// Navigation bar height.
let  kNavigationBarHeight = 44.0

// Tabbar height.
let  kTabbarHeight     =    (kiPhoneX ? (49.0+34.0) : 49.0)

// Tabbar safe bottom margin.
let  kTabbarSafeBottomMargin     =    (kiPhoneX ? 34.0 : 0.0)

// Status bar & navigation bar height.
let  kStatusBarAndNavigationBarHeight = (kiPhoneX ? 88.0 : 64.0)

// Status bar & navigation bar &Tabbar height.
let  kStatusBarAndNavigationBarAndTabbarHeightHeight = CGFloat(kTabbarHeight+kStatusBarAndNavigationBarHeight)

