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

protocol VPNetworkManagerProtocol {
    
    static func loadNewsVideo(completionHandler:@escaping(_ maxBehotTime:TimeInterval,_ newsVideo:[VPNewsVideoModel])->())
}
struct VPNetworkManager:VPNetworkManagerProtocol {
    
}
extension VPNetworkManagerProtocol{
    static func loadNewsVideo(completionHandler:@escaping(_ maxBehotTime:TimeInterval,_ newsVideo:[VPNewsVideoModel])->()){
      
        let BASE_URL = "https://is.snssdk.com"
        let device_id: Int = 6096495334
        let iid: Int = 5034850950
        let pullTime = Date().timeIntervalSince1970
        let url = BASE_URL + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": 15,
                      "category": "video",
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
                completionHandler(pullTime,datas.flatMap({ VPNewsVideoModel.deserialize(from: $0["content"].string)
                }))
                
                
            }
            
        }
        
        
        
    }
    
}

