//
//  DiscussDetailPostCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/6/11.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class DiscussDetailPostCell: UITableViewCell {

    var post : DiscussDetailPost?
    var floor : Int?
    
    class func cellWithTableView(tableView : UITableView) -> DiscussDetailPostCell {
        let ID = NSStringFromClass(self)
        var cell : DiscussDetailPostCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? DiscussDetailPostCell
        if cell == nil {
            cell = DiscussDetailPostCell(style: .default, reuseIdentifier: ID)
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
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.nameTextLabel)
        self.contentView.addSubview(self.timeTextLabel)
        self.contentView.addSubview(self.floorTextLabel)
        self.contentView.addSubview(self.contentTextLabel)
        self.contentView.addSubview(self.underLineView)
    }
    
    private func snp_subViews() {
        self.imgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.top.left.equalToSuperview().offset(10)
        }
        
        self.nameTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView.snp.right).offset(10)
            make.centerY.equalTo(self.imgView)
        }
        
        self.timeTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameTextLabel.snp.right).offset(10).priority(.medium)
            make.right.equalTo(self.floorTextLabel.snp.left).offset(-10).priority(.low)
            make.centerY.equalTo(self.imgView)
        }
        
        self.floorTextLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(self.imgView)
        }
        
        self.contentTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.underLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.equalTo(self.contentTextLabel.snp.bottom).offset(10)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    // MARK: - publick
    public func setupDiscussDetailComment(post : DiscussDetailPost, floor : Int) {
        self.post = post
        self.floor = floor
        
        self.nameTextLabel.text = post.author
        self.timeTextLabel.text = post.dateline?.replacingOccurrences(of: "&nbsp;", with: "")
        self.floorTextLabel.text = "\(floor)#"
        self.contentTextLabel.text = post.message
    }
    
    // MARK: - setter / getter
    lazy var imgView : UIImageView = {
        let imgView : UIImageView = UIImageView()
        imgView.image = UIImage(named: "defult_pho")
        return imgView
    }()
    
    lazy var nameTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGB(r: 186, g: 177, b: 161)
        return label
    }()
    
    lazy var timeTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = RGB(r: 163, g: 163, b: 163)
        return label
    }()
    
    lazy var floorTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = RGB(r: 163, g: 163, b: 163)
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
        let lineView : UIView = UIView()
        lineView.backgroundColor = RGB(r: 222, g: 222, b: 222)
        return lineView
    }()

}
