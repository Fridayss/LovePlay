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
        return cell!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private
    func addSubViews() {
        self.contentView.addSubview(self.pagerImgView)
        self.contentView.addSubview(self.titleTextLabel)
    }
    
    func snp_subViews() {
        self.pagerImgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    fileprivate var _imageInfoModel : RecommendImageInfoModel?
    var imageInfoModel : RecommendImageInfoModel? {
        set {
            _imageInfoModel = newValue
            let imgURL = URL(string: (newValue?.imgUrl)!)
            self.pagerImgView.kf.setImage(with: imgURL)
            
            self.titleTextLabel.text = newValue?.title
        }
        
        get {
            return _imageInfoModel
        }
    }
    
    // MARK: - lazy load
    lazy var pagerImgView : UIImageView = {
        let pagerImgView : UIImageView = UIImageView()
        
        return pagerImgView
    }()
    
    lazy var titleTextLabel : UILabel = {
        let titleTextLabel : UILabel = UILabel()
        titleTextLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        titleTextLabel.font = UIFont.systemFont(ofSize: 14)
        titleTextLabel.textColor = UIColor.white
        titleTextLabel.textAlignment = NSTextAlignment.center
        return titleTextLabel
    }()
}
