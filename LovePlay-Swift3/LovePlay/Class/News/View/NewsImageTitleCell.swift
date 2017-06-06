//
//  NewsImageTitleCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/30.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsImageTitleCell: UITableViewCell {

    class func cellWithTableView(tableView : UITableView) -> NewsImageTitleCell {
        let ID = NSStringFromClass(self)
        var cell : NewsImageTitleCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? NewsImageTitleCell
        if cell == nil {
            cell = NewsImageTitleCell(style: .default, reuseIdentifier: ID)
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
        self.contentView.addSubview(self.titleTextLabel)
        self.contentView.addSubview(self.timeTextLabel)
        self.contentView.addSubview(self.replyButton)
    }
    
    private func snp_subViews() {
        self.imgView.snp.makeConstraints { (make) in
            make.height.equalTo(120);
            make.top.left.right.equalToSuperview();
        }
        
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp.bottom).offset(10);
            make.left.equalToSuperview().offset(10);
            make.right.equalToSuperview().offset(-10);
        }
        
        self.timeTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleTextLabel)
            make.right.equalTo(self.replyButton.snp.left).offset(10)
            make.centerY.equalTo(self.replyButton)
        }
        
        self.replyButton.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(20)
            make.top.equalTo(self.titleTextLabel.snp.bottom).offset(10)
            make.right.equalTo(self.titleTextLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    fileprivate var _listModel : NewsListModel?
    var listModel : NewsListModel? {
        set {
            _listModel = newValue
            
            let imgSrc = (newValue?.imgsrc.first)!
            let imgURL = URL(string: imgSrc)
            self.imgView.kf.setImage(with: imgURL)
            
            self.titleTextLabel.text = newValue?.title
            var ptime = newValue?.ptime
            if !(ptime?.isEmpty)! {
                ptime = ptime?.components(separatedBy: "").first
            }
            self.timeTextLabel.text = ptime
            self.replyButton .setTitle(newValue?.replyCount.stringValue, for: .normal)
        }
        
        get {
            return _listModel
        }
    }
    
    // MARK: - lazy load
    lazy var imgView : UIImageView = {
        let imgView : UIImageView = UIImageView()
        return imgView
    }()
    
    lazy var titleTextLabel : UILabel = {
        let titleTextLabel : UILabel = UILabel()
        titleTextLabel.numberOfLines = 2
        titleTextLabel.textColor = RGB(r: 36, g: 36, b: 36)
        titleTextLabel.font = UIFont.systemFont(ofSize: 16)
        return titleTextLabel
    }()
    
    lazy var timeTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = RGB(r: 150, g: 150, b: 150)
        return label
    }()
    
    lazy var replyButton : UIButton = {
        let replyButton : UIButton = UIButton()
        replyButton.setTitleColor(RGB(r: 150, g: 150, b: 150), for: .normal)
        replyButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        replyButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5)
        replyButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        replyButton.setTitle("0", for: .normal)
        replyButton.setImage(UIImage(named: "common_chat_new"), for: .normal)
        return replyButton
    }()
    
    lazy var underLineView : UIView = {
        let underLineView : UIView = UIView()
        underLineView.backgroundColor = RGB(r: 222, g: 222, b: 222)
        return underLineView
    }()

}
