//
//  NewsCommentCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/22.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsCommentCell: UITableViewCell {

    class func cellWithTableView(tableView : UITableView) -> NewsCommentCell {
        let ID = "NewsCommentCell"
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
        self.addSubview(avartImgView)
        self.addSubview(voteButton)
        self.addSubview(nameTextLabel)
        self.addSubview(loctionTextLabel)
        self.addSubview(contentTextLabel)
        self.addSubview(underLineView)
    }
    
    private func snp_subViews() {
        avartImgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        voteButton.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(20)
            make.top.equalTo(avartImgView)
            make.right.equalToSuperview().offset(-10);
        }
        
        nameTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avartImgView)
            make.left.equalTo(avartImgView.snp.right).offset(10)
            make.right.equalTo(voteButton.snp.left).offset(-10)
        }
        
        loctionTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameTextLabel)
            make.bottom.equalTo(avartImgView.snp.bottom)
        }
        
        contentTextLabel.snp.makeConstraints { (make) in
            
        }
        
        underLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.equalTo(contentTextLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
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
        
        return contentTextLabel
    }()
    
    lazy var underLineView : UIView = {
        let contentTextLabel = UIView()
        
        return contentTextLabel
    }()
}
