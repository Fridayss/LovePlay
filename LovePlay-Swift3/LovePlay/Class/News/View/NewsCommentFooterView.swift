//
//  NewsCommentFooterView.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/21.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

typealias NewsCommentFooterClickBlock = () -> ()

class NewsCommentFooterView: UITableViewHeaderFooterView {

    var footerClickBlock : NewsCommentFooterClickBlock?
    
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
        self.contentView.backgroundColor = UIColor.white
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private
    private func addSubViews() {
        self.addSubview(self.titleButton)
    }
    
    private func snp_subViews() {
        self.titleButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
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
    
    //MARK: - publick
    public func commentFooterClickBlock(didClickedBlock : @escaping NewsCommentFooterClickBlock) {
        self.footerClickBlock = didClickedBlock
    }
    
    //MARK: - target-action
    func footerButtonClick() {
        if self.footerClickBlock != nil {
            self.footerClickBlock!()
        }
    }
    
    // MARK: - lazy load
    lazy var titleButton : UIButton = {
        let titleButton = UIButton()
        titleButton .setTitle("footer", for: .normal)
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        titleButton.setTitleColor(RGB(r: 215, g: 84, b: 107), for: .normal)
        titleButton.addTarget(self, action: #selector(self.footerButtonClick), for: .touchUpInside)
        return titleButton
    }()

}
