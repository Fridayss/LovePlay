//
//  NewsCommentReplyView.swift
//  LovePlay
//
//  Created by Yuns on 2017/6/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsCommentReplyView: UIView {

    fileprivate var item : CommentItemModel?
    fileprivate var floor : String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public
    public func setupCommentReplyView(item : CommentItemModel, floor : String) {
        self.item = item
        self.floor = floor
        
        self.addSubViews()
        self.snp_subViews()
        
        let nickname = item.user?.nickname != nil ? (item.user?.nickname)! : "火星网友"
        let location = item.user?.location != nil ? (item.user?.location)! : "火星"
        self.nameTextLabel.text = nickname + location
        self.floorTextLabel.text = "#" + floor
        self.contentTextLabel.text = item.content != nil ? item.content : "NULL"
    }
    
    //MARK: - private
    private func addSubViews() {
        self.addSubview(self.nameTextLabel)
        self.addSubview(self.floorTextLabel)
        self.addSubview(self.contentTextLabel)
        self.addSubview(self.underLineView)
    }
    
    private func snp_subViews() {
        self.nameTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(4)
            make.right.equalTo(self.floorTextLabel.snp.left).offset(-10)
        }
        
        self.floorTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(30).priority(.low)
            make.top.equalToSuperview().offset(4);
            make.right.equalToSuperview().offset(-4)
        }
        
        self.contentTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameTextLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
        }
        
        self.underLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.equalTo(self.contentTextLabel.snp.bottom).offset(4)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    //MARK: - setter / getter
    lazy var nameTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGB(r: 186, g: 177, b: 161)
        return label
    }()
    
    lazy var floorTextLabel :UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = RGB(r: 64, g: 64, b: 64)
        label.textAlignment = .right
        return label
    }()
    
    lazy var contentTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGB(r: 50, g: 50, b: 50)
        return label
    }()
    
    lazy var underLineView : UIView = {
        let underLineView = UIView()
        underLineView.backgroundColor = RGB(r: 222, g: 222, b: 222)
        return underLineView
    }()
}
