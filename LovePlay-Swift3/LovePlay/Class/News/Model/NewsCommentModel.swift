//
//  NewsCommentModel.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/19.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import HandyJSON

struct CommentUserModel : HandyJSON {
    var avatar : String?
    var location : String?
    var nickname : String?
}

struct CommentItemModel : HandyJSON {
    var content : String?
    var createTime : String?
    var siteName : String?
    var vote : Int?
    var user : CommentUserModel?
}

class NewsCommentModel: HandyJSON {
    var commentIds : [String]?
    var comments : CommentItemModel?
    required init(){}
}
