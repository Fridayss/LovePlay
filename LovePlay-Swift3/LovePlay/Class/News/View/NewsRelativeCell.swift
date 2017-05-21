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
        let ID = "NewsRelativeCell"
        
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
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titleTextLabel)
        self.contentView.addSubview(timeTextLabel)
        self.contentView.addSubview(underLineView)
    }
    
    private func snp_subViews() {
        imgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        titleTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView);
            make.left.equalTo(imgView.snp.right).offset(10);
            make.right.equalToSuperview().offset(-10);
        }
        
        timeTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleTextLabel);
            make.bottom.equalTo(imgView.snp.bottom);
        }
        
        underLineView.snp.makeConstraints { (make) in
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
            imgView.kf.setImage(with: imgURL)
            
            titleTextLabel.text = newValue?.title
            timeTextLabel.text = (newValue?.source)! + " " + (newValue?.ptime)!
        }
        
        get {
            return _relativeModel
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
    
    lazy var timeTextLabel : UILabel = {
        let timeTextLabel : UILabel = UILabel()
        return timeTextLabel
    }()
    
    lazy var underLineView : UIView = {
        let underLineView : UIView = UIView()
        underLineView.backgroundColor = UIColor.lightGray
        return underLineView
    }()
}
