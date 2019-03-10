//
//  VPNetworkManager.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/7.
//  Copyright © 2018年 icoin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD
protocol VPNetworkManagerProtocol {
    // MARK: - ---------------------------------- 西瓜视频 ----------------------------------
    static func loadNewsVideo(categary:String,completionHandler:@escaping(_ maxBehotTime:TimeInterval,_ newsVideo:[VPNewsVideoModel])->())
    
    static func parseVideoRealURL(video_id:String,completionHandler:@escaping(_ realVideo:RealVideo)->())
}

struct VPNetworkManager:VPNetworkManagerProtocol {
    
}


extension VPNetworkManagerProtocol{
    // MARK: - ---------------------------------- 视频列表 ----------------------------------
    static func loadNewsVideo(categary:String,completionHandler:@escaping(_ maxBehotTime:TimeInterval,_ newsVideo:[VPNewsVideoModel])->()){
      
        let pullTime = Date().timeIntervalSince1970
        let url = NEWS_VIDEO_BASE_URL + NEWS_VIDEO_LIST_PATH
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": 15,
                      "category": categary,//ugc_video_beauty video
                      "min_behot_time": pullTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": "pull",
                      "iid": iid] as [String: Any]
        
       
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value{
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                guard let datas = json["data"].array else {
                    return
                }
                completionHandler(pullTime,datas.compactMap({ VPNewsVideoModel.deserialize(from: $0["content"].string)
                }))
            }
        }
    }
    
    // MARK: - ---------------------------------- 视频地址请求 ----------------------------------
    static func parseVideoRealURL(video_id:String,completionHandler:@escaping(_ realVideo:RealVideo)->()){
        
        let r = arc4random()
        let url :NSString = "/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)" as NSString
        let data: NSData = url.data(using: String.Encoding.utf8.rawValue)! as NSData
        
        var crc32:UInt64 = UInt64(data.getCRC32())
        if crc32 < 0 {
            crc32 += 0x100000000
        }
        // 拼接 url
//        let realURL = "https://i.snssdk.com/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)&s=\(crc32)"
        let realURL = NEWS_VIDEO_BASE_URL+NEWS_VIDEO_REAL_PLAY_PATH+"\(video_id)?r=\(r)&s=\(crc32)"
        
        Alamofire.request(realURL).responseJSON { (response) in
    
            guard response.result.isSuccess else{return}
            
            if let value = response.result.value {
                completionHandler(RealVideo.deserialize(from: JSON(value)["data"].dictionaryObject)!)
            }
            
        }
       
    }
}

