//
//  NewsSectionHeaderView.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/21.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsSectionHeaderView: UITableViewHeaderFooterView {
    
    class func sectionHeaderWithTableView(tableView : UITableView) -> NewsSectionHeaderView {
        let ID = NSStringFromClass(self)
        var sectionHeader : NewsSectionHeaderView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: ID) as? NewsSectionHeaderView
        if sectionHeader == nil {
            sectionHeader = NewsSectionHeaderView(reuseIdentifier: ID)
        }
        return sectionHeader!
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var _titleText : String?
    var titleText : String? {
        set {
            _titleText = newValue
            self.titleTextlabel.text = newValue
        }
        
        get {
            return _titleText
        }
    }
    
    // MARK: - private
    private func addSubViews() {
        self.addSubview(self.leftLineView)
        self.addSubview(self.titleTextlabel)
    }
    
    private func snp_subViews() {
        self.leftLineView.snp.makeConstraints { (make) in
            make.width.equalTo(3)
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        self.titleTextlabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(leftLineView.snp.right).offset(8)
        }
    }
    
    // MARK: - lazy load
    lazy var leftLineView : UIView = {
        let leftLineView = UIView()
        leftLineView.backgroundColor = RGB(r: 218, g: 85, b: 107)
        return leftLineView
    }()
    
    lazy var titleTextlabel : UILabel = {
        let titleTextLabel = UILabel()
        titleTextLabel.text = "header"
        titleTextLabel.font = UIFont.systemFont(ofSize: 12)
        titleTextLabel.textColor = RGB(r: 155, g: 155, b: 155)
        return titleTextLabel
    }()
}
