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
    fileprivate var _commentIds : NSArray?
    var commentIds : NSArray? {
        set {
            _commentIds = newValue
        }
        
        get {
            let commentIdsArr = NSArray()
            if _commentIds?.count != 0 {
                for floor in _commentIds! {
                    let floors : Array = (floor as AnyObject).components(separatedBy: ",")
                    commentIdsArr.adding(floors)
                }
            }
            
            return commentIdsArr
        }
    }
    
//    var comments : NSDictionary?
    fileprivate var _comments : NSDictionary?
    var comments : NSDictionary? {
        set {
            self.comments = newValue
        }
        
        get {
            let commentsDict = NSDictionary()
            _comments?.enumerateKeysAndObjects({ (key, obj, stop) in
                let commentItemModel : CommentItemModel = CommentItemModel.deserialize(from: obj as? NSDictionary)!
                commentsDict.setValue(commentItemModel, forKey: key as! String)
            })
            return self.comments
        }
    }
    required init(){}
}
