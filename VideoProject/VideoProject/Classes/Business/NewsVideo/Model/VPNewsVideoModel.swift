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
    
}
struct VideoDetailInfo:HandyJSON {
     var video_id: String = ""
}


