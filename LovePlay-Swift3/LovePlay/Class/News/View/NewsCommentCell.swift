//
//  NewsCommentCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/22.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsCommentCell: UITableViewCell {

    var _commentItems : NSDictionary?
    var _commmentIds : NSArray?
    
    // MARK: - init
    class func cellWithTableView(tableView : UITableView) -> NewsCommentCell {
        let ID = NSStringFromClass(self)
        var cell : NewsCommentCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? NewsCommentCell
        if cell == nil {
            cell = NewsCommentCell(style: .default, reuseIdentifier: ID)
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private
    private func addSubViews() {
        self.addSubview(self.avartImgView)
        self.addSubview(self.voteButton)
        self.addSubview(self.nameTextLabel)
        self.addSubview(self.loctionTextLabel)
        self.addSubview(self.contentTextLabel)
        self.addSubview(self.underLineView)
        self.addSubview(self.replyAreaView)
    }
    
    private func snp_subViews() {
        self.avartImgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        self.voteButton.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(20)
            make.top.equalTo(avartImgView)
            make.right.equalToSuperview().offset(-10);
        }
        
        self.nameTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avartImgView)
            make.left.equalTo(avartImgView.snp.right).offset(10)
            make.right.equalTo(voteButton.snp.left).offset(-10)
        }
        
        self.loctionTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameTextLabel)
            make.bottom.equalTo(avartImgView.snp.bottom)
        }
        
        self.contentTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avartImgView.snp.bottom).offset(10)
            make.left.equalTo(nameTextLabel)
            make.right.equalTo(voteButton)
        }
        
        self.underLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.equalTo(contentTextLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.replyAreaView.snp.makeConstraints { (make) in
            make.top.equalTo(self.avartImgView.snp.bottom).offset(10)
            make.left.equalTo(self.nameTextLabel)
            make.right.equalTo(self.voteButton)
        }
    }
    
    // MARK: - public
    public func setupComment(commentItems : NSDictionary, commmentIds : NSArray) {
        _commentItems = commentItems
        _commmentIds = commmentIds
        
        let itemModel : CommentItemModel = commentItems[commmentIds.lastObject!] as! CommentItemModel
        
        var imgURL : URL? = URL(string: "")
        if let imgSrc = itemModel.user?.avatar {
            imgURL = URL(string: imgSrc)
        }
//        self.avartImgView.kf.setImage(with: imgURL)
        self.avartImgView.kf.setImage(with: imgURL, placeholder: UIImage(named: "defult_pho"))
        
        self.nameTextLabel.text = itemModel.user?.nickname != nil ? itemModel.user?.nickname : "火星网友"
        self.loctionTextLabel.text = itemModel.user?.location != nil ? itemModel.user?.location : "火星"
        self.voteButton.setTitle((itemModel.vote!).description + "顶", for: .normal)
        self.contentTextLabel.text = itemModel.content
        
        if commmentIds.count > 1 {
            self.contentTextLabel.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.replyAreaView.snp.bottom).offset(10)
                make.left.equalTo(self.nameTextLabel)
                make.right.equalTo(self.voteButton)
            })
        } else {
            self.contentTextLabel.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.avartImgView.snp.bottom).offset(10)
                make.left.equalTo(self.nameTextLabel)
                make.right.equalTo(self.voteButton)
            })
        }
        self.replyAreaView.setupCommentReplyAreaView(items: commentItems, floors: commmentIds)
    }
    
    
    // MARK: - lazy load
    lazy var avartImgView : UIImageView = {
        let avartImgView = UIImageView()
        return avartImgView
    }()
    
    lazy var voteButton : UIButton = {
        let voteButton = UIButton()
        voteButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        voteButton.contentHorizontalAlignment = .right
        voteButton.setTitleColor(RGB(r: 163, g: 163, b: 163), for: .normal)
        return voteButton
    }()
    
    lazy var nameTextLabel : UILabel = {
        let nameTextLabel = UILabel()
        nameTextLabel.font = UIFont.systemFont(ofSize: 14)
        nameTextLabel.textColor = RGB(r: 186, g: 177, b: 161)
        return nameTextLabel
    }()
    
    lazy var loctionTextLabel : UILabel = {
        let loctionTextLabel = UILabel()
        loctionTextLabel.font = UIFont.systemFont(ofSize: 12)
        loctionTextLabel.textColor = RGB(r: 163, g: 163, b: 163)
        return loctionTextLabel
    }()
    
    lazy var contentTextLabel : UILabel = {
        let contentTextLabel = UILabel()
        contentTextLabel.numberOfLines = 0
        contentTextLabel.font = UIFont.systemFont(ofSize: 14)
        contentTextLabel.textColor = RGB(r: 50, g: 50, b: 50)
        return contentTextLabel
    }()
    
    lazy var underLineView : UIView = {
        let underLineView = UIView()
        underLineView.backgroundColor = RGB(r: 222, g: 222, b: 222)
        return underLineView
    }()
    
    lazy var replyAreaView : NewsCommentReplyAreaView = {
        let replyAreaView = NewsCommentReplyAreaView()
        
        return replyAreaView
    }()
}
