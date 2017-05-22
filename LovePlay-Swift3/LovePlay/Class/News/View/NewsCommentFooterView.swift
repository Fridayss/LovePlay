//
//  NewsCommentFooterView.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/21.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsCommentFooterView: UITableViewHeaderFooterView {

    class func sectionHeaderWithTableView(tableView : UITableView) -> NewsCommentFooterView {
        let ID = NSStringFromClass(self)
        var sectionFooter : NewsCommentFooterView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: ID) as? NewsCommentFooterView
        if sectionFooter == nil {
            sectionFooter = NewsCommentFooterView(reuseIdentifier: ID)
        }
        return sectionFooter!
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
            titleButton.setTitle(newValue, for: .normal)
        }
        
        get {
            return _titleText
        }
    }
    
    // MARK: - private
    private func addSubViews() {
        self.addSubview(titleButton)
    }
    
    private func snp_subViews() {
        titleButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - lazy load
    lazy var titleButton : UIButton = {
        let titleButton = UIButton()
        titleButton .setTitle("footer", for: .normal)
        return titleButton
    }()

}
