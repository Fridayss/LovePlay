//
//  RecommendScrollCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/22.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class RecommendScrollCell: UICollectionViewCell {
    class func cellWithCollectionView(collectionView : UICollectionView, indexPath: IndexPath) -> RecommendScrollCell {
        
        let ID = NSStringFromClass(self)
        let cell : RecommendScrollCell? = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as? RecommendScrollCell
        
        cell?.contentView.backgroundColor = UIColor.yellow
        return cell!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
