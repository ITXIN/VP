//
//  VPNewsVideoPlayModel.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/8.
//  Copyright © 2018年 icoin. All rights reserved.
//

import Foundation
import HandyJSON
struct RealVideo:HandyJSON {
    var video_list = VideoList()
    
}

struct VideoList:HandyJSON {
    var video_1 = Video()
    
}
struct Video:HandyJSON {
    var main_url:String = ""
    var mainURL:String  {
        
        let decodeData = Data.init(base64Encoded: main_url, options: Data.Base64DecodingOptions(rawValue:0))
        return String(data:decodeData!,encoding:.utf8)!
    }
    var play_addr = PlayAddr()
    
}
struct PlayAddr: HandyJSON {
    var uri: String = ""
    var url_list = [String]()
}
