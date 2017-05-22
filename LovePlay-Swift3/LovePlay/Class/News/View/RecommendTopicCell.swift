//
//  RecommendTopicCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/22.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class RecommendTopicCell: UICollectionViewCell {
    
    class func cellWithCollectionView(collectionView : UICollectionView, indexPath: IndexPath) -> RecommendTopicCell {
        
        let ID = NSStringFromClass(self)
        let cell : RecommendTopicCell? = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as? RecommendTopicCell
        
        cell?.contentView.backgroundColor = UIColor.red
        return cell!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private
    private func addSubViews() {
        self.addSubview(topicImgView)
        self.addSubview(topicTextLabel)
    }
    
    private func snp_subViews() {
        topicImgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            make.right.equalToSuperview().offset(-2)
            make.height.equalTo(topicImgView.width)
        }
        
        topicTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topicImgView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
    }
    
    // MARK: - lazy load
    lazy var topicImgView : UIImageView = {
        let topicImgView = UIImageView()
        
        return topicImgView
    }()
    
    lazy var topicTextLabel : UILabel = {
        let topicTextLabel = UILabel()
        
        return topicTextLabel
    }()
}
