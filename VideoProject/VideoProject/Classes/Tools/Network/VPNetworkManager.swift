//
//  VPNetworkManager.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/7.
//  Copyright © 2018年 icoin. All rights reserved.
//

import Foundation
import Alamofire
//import SwiftyJSON
import SVProgressHUD
protocol VPNetworkManagerProtocol {
    // MARK: - ---------------------------------- 西瓜视频 ----------------------------------
    static func loadNewsVideo(categary:String,completionHandler:@escaping(_ maxBehotTime:TimeInterval,_ newsVideo:[VPNewsVideoModel?])->())
    
    static func parseVideoRealURL(video_id:String,completionHandler:@escaping(_ realVideo:RealVideo)->())
}

struct VPNetworkManager: VPNetworkManagerProtocol {
    
    // MARK: - ---------------------------------- 视频列表 ----------------------------------
    static func loadNewsVideo(categary:String,completionHandler:@escaping(_ maxBehotTime:TimeInterval,_ newsVideo:[VPNewsVideoModel?])->()){
        
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
        
        AF.request(url,method:.post, parameters: params).responseString { (response) in
            guard (response.value != nil) else {
                return
            }
            
            switch response.result {
            case let .success(body):
                
                let jsonData:Data = body.data(using: .utf8)!
                
                let tempDic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                
                let dic = (tempDic as? Dictionary<String, Any>)
                if let keyArr = dic?.keys {
                    for item:String in keyArr {
                        if "data" == item {
                            
                            guard let datas = dic?[item] as? Array<Any> else {
                                continue;
                            }
                            var listArr = [Any]()
                            for item in datas {
                                
                                if let dicCon = (item as! Dictionary<String, Any>)["content"] as? String {
                                    
                                    let contentJsonData:Data = dicCon.data(using: .utf8)!
                                    
                                    let contentDicTemp = try? JSONSerialization.jsonObject(with: contentJsonData, options: .mutableContainers)
                                    
                                    
                                    let contentDic = (contentDicTemp as! Dictionary<String, Any>)
                                    
                                    listArr.append(contentDic)
                                }
                                
                            }
                            
                            if let videArr = [VPNewsVideoModel].deserialize(from: listArr) {
                                completionHandler(pullTime,videArr)
                            }else{
                                
                            }
                            break
                        }
                    }
                    
                }
                
                break
            case let .failure(error):
                VPLog("error: \(error)")
                completionHandler(pullTime,[])
                break
                
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
        
        AF.request(realURL).responseJSON { (response) in
            
            guard (response.value != nil) else{return}
            
            switch response.result {
            case let .success(body):
                
                let dic = (body as? Dictionary<String, Any>)
                if let keyArr = dic?.keys {
                    for item:String in keyArr {
                        if "data" == item {
                            
                            guard let datas = dic?[item] as? Dictionary<String,Any> else {
                                continue;
                            }
                            if let video = RealVideo.deserialize(from: datas) {
                                completionHandler(video)
                            }
                            break
                        }
                    }
                }
                
                break
            case let .failure(error):
                VPLog("error: \(error)")
                if let video = RealVideo.deserialize(from: ["data":""]) {
                    completionHandler(video)
                }
                break
                
            }
        }
        
    }
    
}

