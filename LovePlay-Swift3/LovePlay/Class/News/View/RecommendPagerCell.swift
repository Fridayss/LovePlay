//
//  RecommendPagerCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/22.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class RecommendPagerCell: UICollectionViewCell {
    class func cellWithCollectionView(collectionView : UICollectionView, indexPath: IndexPath) -> RecommendPagerCell {
        
        let ID = NSStringFromClass(self)
        let cell : RecommendPagerCell? = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as? RecommendPagerCell
        
        cell?.contentView.backgroundColor = UIColor.red
        return cell!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
