//
//  ZoneListCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/6/4.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class ZoneListCell: UICollectionViewCell {

    class func cellWithCollectionView(collectionView : UICollectionView, indexPath: IndexPath) -> ZoneListCell {
        let ID = NSStringFromClass(self)
        let cell : ZoneListCell? = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as? ZoneListCell
        return cell!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.white
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private
    func addSubViews() {
        self.contentView.addSubview(self.titleTextLabel)
        self.contentView.addSubview(self.detailTextLabel)
        self.contentView.addSubview(self.discussImgView)
    }
    
    func snp_subViews() {
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.discussImgView).offset(3)
            make.left.equalTo(self.discussImgView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.detailTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.titleTextLabel)
            make.bottom.equalTo(self.discussImgView.snp.bottom).offset(-3)
        }
        
        self.discussImgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate var _listModel : ZoneDiscussItem?
    var listModel : ZoneDiscussItem? {
        set {
            _listModel = newValue
            let imrURL = URL(string: (newValue?.iconUrl)!)
            self.discussImgView.kf.setImage(with: imrURL)
            self.titleTextLabel.text = newValue?.modelName
            self.detailTextLabel.text = newValue?.modelDesc
        }
        
        get {
            return _listModel
        }
    }
    
    // MARK: - setter / getter
    lazy var titleTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGB(r: 36, g: 36, b: 36)
        return label;
    }()
    
    lazy var detailTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = RGB(r: 150, g: 150, b: 150)
        return label;
    }()
    
    lazy var discussImgView : UIImageView = {
        let discussImgView : UIImageView = UIImageView()
        return discussImgView
    }()

}
