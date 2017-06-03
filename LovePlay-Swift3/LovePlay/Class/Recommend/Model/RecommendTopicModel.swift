//
//  RecommendTopicModel.swift
//  LovePlay
//
<<<<<<< HEAD
//  Created by Yuns on 2017/5/30.
=======
//  Created by weiying on 2017/5/27.
>>>>>>> 1875739c6fa8c4890ae7b045ac14824f393cd618
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import HandyJSON

class RecommendTopicModel: HandyJSON {
<<<<<<< HEAD
=======
    
>>>>>>> 1875739c6fa8c4890ae7b045ac14824f393cd618
    var bannerUrl : String?
    var desc : String?
    var iconUrl : String?
    var topicIconName : String?
    var topicId : String?
    var topicName : String?
<<<<<<< HEAD
    var followUserCount : String?
    var platform : String?
    var sourceType : Int?
    
=======
    var followUserCount : Int?
    var platform : Int?
    var sourceType : Int?

>>>>>>> 1875739c6fa8c4890ae7b045ac14824f393cd618
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            desc <-- "description"
    }
    
    required init() {
        
    }
}
