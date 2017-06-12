//
//  DiscussDetailModel.swift
//  LovePlay
//
//  Created by weiying on 2017/6/12.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import HandyJSON

struct DiscussDetailThread : HandyJSON {
    var tid : String?
    var fid : String?
    var author : String?
    var subject : String?
    var lastpost : String?
    var views : String?
    var replies : String?
    var typeName : String?
}

struct DiscussDetailPost : HandyJSON {
    var tid : String?
    var pid : String?
    var author : String?
    var authorid : String?
    var dateline : String?
    var message : String?
    var username : String?
    var replyText : String?
    var first : NSInteger?
}

class DiscussDetailModel: HandyJSON {
    
    var fid : String?
    var thread : DiscussDetailThread?
    var postlist : [DiscussDetailPost]? = [DiscussDetailPost]()
    
    
    required init() {
        
    }
}
