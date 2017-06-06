//
//  NewsTitleImageCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/30.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class NewsTitleImageCell: UITableViewCell {

    class func cellWithTableView(tableView : UITableView) -> NewsTitleImageCell {
        let ID = NSStringFromClass(self)
        var cell : NewsTitleImageCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? NewsTitleImageCell
        if cell == nil {
            cell = NewsTitleImageCell(style: .default, reuseIdentifier: ID)
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
        self.contentView.addSubview(self.underLineView)
    }
    
    private func snp_subViews() {
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10);
            make.left.equalToSuperview().offset(10);
            make.right.equalToSuperview().offset(-10);
        }
        
        self.imgView.snp.makeConstraints { (make) in
            make.height.equalTo(120)
            make.top.equalTo(self.titleTextLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.underLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5);
            make.top.equalTo(self.imgView.snp.bottom).offset(10);
            make.left.bottom.right.equalToSuperview();
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
    
    lazy var underLineView : UIView = {
        let underLineView : UIView = UIView()
        underLineView.backgroundColor =  RGB(r: 222, g: 222, b: 222)
        return underLineView
    }()

}
