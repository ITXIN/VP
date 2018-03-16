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
    var raw_data = SmallVideo() //小视频数据
    
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
// MARK: - ---------------------------------- 小视频 ----------------------------------
struct SmallVideo: HandyJSON {
    let emojiManager = EmojiManager()
    
    var title: String = ""
    var attrbutedText: NSMutableAttributedString {
        return emojiManager.showEmoji(content: title, font: UIFont.systemFont(ofSize: 17))
    }
     var large_image_list = [LargeImage]()
     var first_frame_image_list = [FirstFrameImage]()
    var action = SmallVideoAction()
}
struct FirstFrameImage: HandyJSON {
    var uri: String = ""
    var image_type: Int = 0
    var url_list = [URLList]()
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width: Int = 0
    var height: Int = 0
}

struct SmallVideoAction: HandyJSON {
    var bury_count = 0
    var buryCount: String { return bury_count.convertString() }
    var comment_count = 0
    var commentCount: String { return comment_count.convertString() }
    var digg_count = 0
    var diggCount: String { return digg_count.convertString() }
    var forward_count = 0
    var forwardCount: String { return forward_count.convertString() }
    var play_count = 0
    var playCount: String { return play_count.convertString() }
    var read_count = 0
    var readCount: String { return read_count.convertString() }
    var user_bury = 0
    var userBury: String { return user_bury.convertString() }
    var user_repin = 0
    var userRepin: String { return user_repin.convertString() }
    var user_digg = false
}
