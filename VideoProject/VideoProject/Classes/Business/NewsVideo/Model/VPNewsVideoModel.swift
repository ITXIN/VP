//
//  VPNewsVideoModel.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/7.
//  Copyright © 2018年 icoin. All rights reserved.
//

import Foundation
import HandyJSON
struct VPNewsVideoModel: HandyJSON {
    var abstract = ""
    var display_url = ""
    var video_detail_info = VideoDetailInfo()
    var user_info = UserInfo()
    var title = ""
    
    
}

struct VideoDetailInfo:HandyJSON {
    var video_id: String = ""
    var detail_video_large_image = DetailVideoLargeImage()
    
}

struct UserInfo:HandyJSON {
    var avatar_url: String = ""
     var name: String = ""
}

struct URLList: HandyJSON {
    var url: String = ""
}
struct DetailVideoLargeImage:HandyJSON {
    var height: Int = 0
    var url_list: [URLList]!
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width: Int = 0
    var uri: String = ""
}

