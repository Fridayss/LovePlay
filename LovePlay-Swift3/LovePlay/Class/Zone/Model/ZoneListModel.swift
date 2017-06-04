//
//  ZoneListModel.swift
//  LovePlay
//
//  Created by Yuns on 2017/6/4.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import HandyJSON

struct ZoneDiscussItem : HandyJSON {
    var bannerUrl : String?
    var discuzModelTypeId : String?
    var fid : String?
    var iconUrl : String?
    var modelDesc : String?
    var modelName : String?
    var todayPosts : String?
    var weight : String?
}

struct ZoneDiscussType : HandyJSON {
    var category : String?
    var typeId : String?
    var typeName : String?
    var weight : String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            typeId <-- "id"
    }
}

class ZoneListModel: HandyJSON {
    
    var detailList : [ZoneDiscussItem]?
    var type : ZoneDiscussType?
    
    required init() {
        
    }
}
