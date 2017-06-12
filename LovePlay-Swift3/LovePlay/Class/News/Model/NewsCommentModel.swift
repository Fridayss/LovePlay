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
//    var commentIds : NSArray?
//    var comments : NSDictionary?
    var commentIds : [String]? // json转model对应的key
    var commentIdsSB : [Any]? { // 自定义一个参数，重写get方法，用于获取处理后的数据
        get {
            var commentIdsArr = [Any]()
            if (commentIds?.count)! > 0 {
                for floor : String in commentIds! {
                    let floors : [String] = (floor as AnyObject).components(separatedBy: ",")
                    commentIdsArr.append(floors)
                }
            }
            
            return commentIdsArr
        }
    }
    
    var comments : NSDictionary?
    var commentsSB : NSDictionary? {
        get {
            let commentsDict = NSMutableDictionary()
            comments?.enumerateKeysAndObjects({ (key, obj, stop) in
                let commentItemModel : CommentItemModel = CommentItemModel.deserialize(from: obj as? NSDictionary)!
                commentsDict.setValue(commentItemModel, forKey: key as! String)
            })
            return commentsDict
        }
        
    }
    

    required init(){}
}
