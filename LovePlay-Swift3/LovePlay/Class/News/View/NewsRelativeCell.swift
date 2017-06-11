//
//  NewsRelativeCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/21.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsRelativeCell: UITableViewCell {

    class func cellWithTableView(tableView : UITableView) -> NewsRelativeCell {
        let ID = NSStringFromClass(self)
        var cell : NewsRelativeCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? NewsRelativeCell
        if cell == nil {
            cell = NewsRelativeCell(style: .default, reuseIdentifier: ID)
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
        
        self.timeTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleTextLabel);
            make.bottom.equalTo(imgView.snp.bottom);
        }
        
        self.underLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5);
            make.top.equalTo(imgView.snp.bottom).offset(10);
            make.left.bottom.right.equalToSuperview();
        }
    }
    
    fileprivate var _relativeModel : DetailRelativeModel?
    // MARK: - public
    var relativeModel : DetailRelativeModel? {
        set {
            _relativeModel = newValue
            
            let imgSrc = (newValue?.imgsrc)!
            let imgURL = URL(string: imgSrc)
            self.imgView.kf.setImage(with: imgURL)
            
            self.titleTextLabel.text = newValue?.title
            self.timeTextLabel.text = (newValue?.source)! + " " + (newValue?.ptime)!
        }
        
        get {
            return _relativeModel
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
        let timeTextLabel : UILabel = UILabel()
        timeTextLabel.font = UIFont.systemFont(ofSize: 10)
        timeTextLabel.textColor = RGB(r: 150, g: 150, b: 150)
        return timeTextLabel
    }()
    
    lazy var underLineView : UIView = {
        let underLineView : UIView = UIView()
        underLineView.backgroundColor = RGB(r: 222, g: 222, b: 222)
        return underLineView
    }()
}
