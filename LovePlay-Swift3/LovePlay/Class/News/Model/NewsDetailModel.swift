//
//  NewsDetailModel.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/19.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import HandyJSON

struct DetailImageModel : HandyJSON {
    var alt : String?
    var pixel : String?
    var ref : String?
    var src : String?
    
}

struct DetailRelativeModel : HandyJSON {
    var docID : String?
    var ID : String?
    var imgsrc : String?
    var ptime : String?
    var source : String?
    var title : String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            ID <-- "id"
    }
}

struct DetailArticleModel : HandyJSON {
    var articleUrl : String?
    var body : String?
    var digest : String?
    var docid : String?
    var ptime : String?
    var shareLink : String?
    var source : String?
    var title : String?
    var replyCount : Int?
    var img : [DetailImageModel]?
    var relative_sys : [DetailRelativeModel]?
    
}

class NewsDetailModel: HandyJSON {
    
    var article : DetailArticleModel?
    var tie : NewsCommentModel?
    required init(){}

}
