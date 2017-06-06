//
//  DiscussListTopCell.swift
//  LovePlay
//
//  Created by weiying on 2017/6/6.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class DiscussListTopCell: UITableViewCell {

    class func cellWithTableView(tableView : UITableView) -> DiscussListTopCell {
        let ID = NSStringFromClass(self)
        var cell : DiscussListTopCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? DiscussListTopCell
        if cell == nil {
            cell = DiscussListTopCell(style: .default, reuseIdentifier: ID)
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
        self.contentView.addSubview(self.topTextLabel)
        self.contentView.addSubview(self.titleTextLabel)
        self.contentView.addSubview(self.underLineView)
    }
    
    private func snp_subViews() {
        self.topTextLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.width.equalTo(45)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.topTextLabel.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(self.topTextLabel)
        }
        
        self.underLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.equalTo(self.topTextLabel.snp.bottom).offset(10)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    fileprivate var _listModel : DiscussListModel?
    var listModel : DiscussListModel? {
        set {
            _listModel = newValue
        }
        
        get {
            return _listModel
        }
    }
    
    //MARK: - setter / getter
    lazy var topTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = RGB(r: 236, g: 126, b: 150)
        return label
    }()
    
    lazy var titleTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = RGB(r: 36, g: 36, b: 36)
        return label
    }()
    
    lazy var underLineView : UIView = {
        let lineView : UIView = UIView()
        lineView.backgroundColor = RGB(r: 222, g: 222, b: 222)
        return lineView
    }()
}
