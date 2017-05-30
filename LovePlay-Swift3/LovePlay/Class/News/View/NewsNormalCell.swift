//
//  NewsNormalCell.swift
//  LovePlay
//
//  Created by weiying on 2017/5/19.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsNormalCell: UITableViewCell {
    
    class func cellWithTableView(tableView : UITableView) -> NewsNormalCell {
        let ID = NSStringFromClass(self)
        var cell : NewsNormalCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? NewsNormalCell
        if cell == nil {
            cell = NewsNormalCell(style: .default, reuseIdentifier: ID)
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
        self.contentView.addSubview(self.replyButton)
        self.contentView.addSubview(self.underLineView)
    }
    
    private func snp_subViews() {
        self.imgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView);
            make.left.equalTo(imgView.snp.right).offset(10);
            make.right.equalToSuperview().offset(-10);
        }
        
        self.replyButton.snp.makeConstraints { (make) in
            make.width.equalTo(50);
            make.height.equalTo(20);
            make.left.equalTo(titleTextLabel.snp.left);
            make.bottom.equalTo(imgView.snp.bottom);
        }
        
        self.underLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5);
            make.top.equalTo(imgView.snp.bottom).offset(10);
            make.left.bottom.right.equalToSuperview();
        }
    }
    
    fileprivate var _listModel : NewsListModel?
    // MARK: - public
    var listModel : NewsListModel? {
        set {
            _listModel = newValue
            
            let imgSrc = (newValue?.imgsrc.first)!
            let imgURL = URL(string: imgSrc)
            self.imgView.kf.setImage(with: imgURL)
            
            self.titleTextLabel.text = newValue?.title
            self.replyButton .setTitle(newValue?.replyCount.stringValue, for: .normal)
        }
        
        get {
            return _listModel
        }
    }
    
    
    
    // MARK: - lazy load
    lazy var imgView : UIImageView = {
        let imgView : UIImageView = UIImageView()
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    
    lazy var titleTextLabel : UILabel = {
        let titleTextLabel : UILabel = UILabel()
        titleTextLabel.numberOfLines = 2
        return titleTextLabel
    }()
    
    lazy var replyButton : UIButton = {
        let replyButton : UIButton = UIButton()
        replyButton.setTitleColor(UIColor.black, for: .normal)
        return replyButton
    }()
    
    lazy var underLineView : UIView = {
        let underLineView : UIView = UIView()
        underLineView.backgroundColor = UIColor.lightGray
        return underLineView
    }()
}
