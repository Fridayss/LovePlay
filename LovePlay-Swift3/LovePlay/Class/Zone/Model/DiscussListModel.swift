//
//  DiscussListModel.swift
//  LovePlay
//
//  Created by weiying on 2017/6/6.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import HandyJSON

class DiscussListModel: HandyJSON {
    var tid : String?
    var typeid : String?
    var author : String?
    var authorid : String?
    var subject : String?
    var dateline : String?
    var lastpost : String?
    var lastposter : String?
    var replies : String?
    var displayorder : Int?

    required init() {
        
    }
}
