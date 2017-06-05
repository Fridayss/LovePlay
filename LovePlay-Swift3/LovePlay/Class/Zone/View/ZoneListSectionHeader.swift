//
//  ZoneListSectionHeader.swift
//  LovePlay
//
//  Created by weiying on 2017/6/5.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class ZoneListSectionHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private
    func addSubViews() {
        self.addSubview(self.titleTextLabel)
    }
    
    func snp_subViews() {
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 8, 0, 8))
        }
    }
    
    fileprivate var _titleName : String?
    var titleName : String? {
        set {
            _titleName = newValue
            self.titleTextLabel.text = newValue
        }
        
        get {
            return _titleName
        }
    }
    
    //MARK: - setter / getter
    lazy var titleTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGB(r: 36, g: 36, b: 36)
        return label
    }()
    
}
