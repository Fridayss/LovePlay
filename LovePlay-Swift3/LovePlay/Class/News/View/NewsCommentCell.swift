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
    }
    
    // MARK: - public
    public func setupComment(commentItems : NSDictionary, commmentIds : NSArray) {
        _commentItems = commentItems
        _commmentIds = commmentIds
        let itemModel : CommentItemModel = commentItems[commmentIds.lastObject!] as! CommentItemModel
        
        let imgSrc = itemModel.user?.avatar
        let imgURL = URL(string: imgSrc!)
        self.avartImgView.kf.setImage(with: imgURL)
        
        self.nameTextLabel.text = itemModel.user?.nickname
        self.loctionTextLabel.text = itemModel.user?.location
        self.voteButton.setTitle((itemModel.vote!).description, for: .normal)
        self.contentTextLabel.text = itemModel.content
        
    }
    
    
    // MARK: - lazy load
    lazy var avartImgView : UIImageView = {
        let avartImgView = UIImageView()
        
        return avartImgView
    }()
    
    lazy var voteButton : UIButton = {
        let voteButton = UIButton()
        
        return voteButton
    }()
    
    lazy var nameTextLabel : UILabel = {
        let nameTextLabel = UILabel()
        
        return nameTextLabel
    }()
    
    lazy var loctionTextLabel : UILabel = {
        let loctionTextLabel = UILabel()
        
        return loctionTextLabel
    }()
    
    lazy var contentTextLabel : UILabel = {
        let contentTextLabel = UILabel()
        contentTextLabel.numberOfLines = 0
        return contentTextLabel
    }()
    
    lazy var underLineView : UIView = {
        let contentTextLabel = UIView()
        
        return contentTextLabel
    }()
}
