//
//  NewsCommentReplyAreaView.swift
//  LovePlay
//
//  Created by Yuns on 2017/6/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsCommentReplyAreaView: UIView {

    fileprivate var items : NSDictionary?
    fileprivate var floors : NSArray?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = RGB(r : 248, g : 249, b : 241);
        self.layer.borderColor = RGB(r : 218, g : 218, b : 218).cgColor;
        self.layer.borderWidth = 0.5;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - public
    public func setupCommentReplyAreaView(items : NSDictionary, floors : NSArray) {
        self.items = items
        self.floors = floors
        
        self.removeAllSubViews()
        
        self.addSubViews(items : items, floors: floors)
    }
    
    //MARK: - private
    private func addSubViews(items : NSDictionary, floors : NSArray) {
        var lastTopView = UIView()
        for i in 0..<(floors.count - 1) {
            let floor = floors[i]
            let item = items[floor] as! CommentItemModel
            
            let commentReplyView = NewsCommentReplyView()
            commentReplyView.setupCommentReplyView(item: item, floor: String((i + 1)))
            self.addSubview(commentReplyView)
            
            self.snp_subViews(index: i, commentReplyView: commentReplyView, lastTopView: lastTopView)
            
            lastTopView = commentReplyView
        }
    }
    
    private func snp_subViews(index : Int, commentReplyView : NewsCommentReplyView, lastTopView : UIView) {
        if 0 == index {
            commentReplyView.snp.makeConstraints({ (make) in
                make.top.left.right.equalToSuperview()
            })
        }else{
            commentReplyView.snp.makeConstraints({ (make) in
                make.top.equalTo(lastTopView.snp.bottom)
                make.left.right.equalToSuperview()
            })
        }
        
        if index == ((self.floors?.count)! - 2) {
            commentReplyView.snp.makeConstraints({ (make) in
                make.bottom.equalToSuperview()
            })
        }
    }
    
    private func removeAllSubViews() {
        while self.subviews.count > 0 {
            self.subviews.last?.removeFromSuperview()
        }
    }
    
    //MARK: - setter / getter
    
}
