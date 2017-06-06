//
//  DiscussListHeaderView.swift
//  LovePlay
//
//  Created by weiying on 2017/6/6.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class DiscussListHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private
    func addSubViews() {
        self.addSubview(self.imgView)
        self.addSubview(self.titleTextLabel)
        self.addSubview(self.descTextLabel)
    }
    
    func snp_subViews() {
        self.imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
        
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.descTextLabel);
            make.bottom.equalTo(self.descTextLabel.snp.top).offset(-5);
        }
        
        self.descTextLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10);
            make.bottom.equalToSuperview().offset(-10);
            make.right.equalToSuperview().offset(-10);
        }
    }
    
    fileprivate var _imgModel : DiscussImgModel?
    var imgModel : DiscussImgModel? {
        set {
            _imgModel = newValue
            let imgURL = URL(string: (newValue?.bannerUrl)!)
            self.imgView.kf.setImage(with: imgURL)
            
            self.titleTextLabel.text = newValue?.modelName
            self.descTextLabel.text = "今日：" + "\((newValue?.todayPosts)!)"
        }
        
        get {
            return _imgModel
        }
    }
    
    //MARK: - setter / getter
    lazy var imgView : UIImageView = {
        let imgView : UIImageView = UIImageView()
        imgView.clipsToBounds = true
        return imgView
    }()
    
    lazy var titleTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var descTextLabel : UILabel = {
        let label : UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
}
