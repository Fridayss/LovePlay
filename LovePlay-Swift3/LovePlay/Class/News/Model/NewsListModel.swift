//
//  NewsListModel.swift
//  LovePlay
//
//  Created by weiying on 2017/3/16.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsListModel: NSObject {
    var digest : String = ""
    var docid : String = ""
    var imgextra : String = ""
    var imgsrc : [String] = [String]()
    var ltitle : String = ""
    var postid : String = ""
    var ptime : String = ""
    var subtitle : String = ""
    var title : String = ""
    var topicId : NSNumber = 0
    var priority : NSNumber = 0
    var replyCount : NSNumber = 0
    var showType : NSNumber = 0

    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
