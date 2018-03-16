//
//  VPUserInfoModel.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/16.
//  Copyright © 2018年 icoin. All rights reserved.
//

import Foundation
import HandyJSON
struct LargeImage: HandyJSON {
    var type = ImageType.normal
    var height: CGFloat = 0
    
    var url_list = [URLList]()
    
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    
    var width: CGFloat = 0
    
    var uri: String = ""
}
