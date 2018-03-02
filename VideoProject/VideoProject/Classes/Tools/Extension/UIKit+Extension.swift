//
//  UIKit+Extension.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    class func vpGrayTextColor() -> UIColor {
        return RGB(130, G: 130, B: 130)
    }
    class func vpThemColor() -> UIColor {
        return RGB(77, G: 139, B: 217)
    }
    class func vpGrayLineColor() -> UIColor {
        return RGB(230, G: 230, B: 230)
    }
    class func vpGrayBgColor() -> UIColor {
        return RGB(246, G: 246, B: 246)
    }
    class func vpBlackTextColor() -> UIColor {
        return RGB(0, G: 0, B: 0)
    }
    
    
}

extension UIImage{
    class func getImageWithColor(color:UIColor,rect:CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
        
    }
}




