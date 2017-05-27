//
//  RecommendTopicModel.swift
//  LovePlay
//
//  Created by weiying on 2017/5/27.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import HandyJSON

class RecommendTopicModel: HandyJSON {
    
    var bannerUrl : String?
    var desc : String?
    var iconUrl : String?
    var topicIconName : String?
    var topicId : String?
    var topicName : String?
    var followUserCount : Int?
    var platform : Int?
    var sourceType : Int?

    func mapping(mapper: HelpingMapper) {
        mapper <<<
            desc <-- "description"
    }
    
    required init() {
        
    }
}
