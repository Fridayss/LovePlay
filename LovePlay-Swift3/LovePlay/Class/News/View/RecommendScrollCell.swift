//
//  RecommendScrollCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/22.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

typealias ScrollPagerDidSelectBlock = (_ docID : String?) -> ()

class RecommendScrollCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectBlock : ScrollPagerDidSelectBlock?
    
    class func cellWithCollectionView(collectionView : UICollectionView, indexPath: IndexPath) -> RecommendScrollCell {
        
        let ID = NSStringFromClass(self)
        let cell : RecommendScrollCell? = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as? RecommendScrollCell
        
        cell?.contentView.backgroundColor = UIColor.yellow
        return cell!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private
    func addSubViews() {
        self.contentView.addSubview(self.pagerCollectionView)
    }
    
    func snp_subViews() {
        self.pagerCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate var _imgInfoDatas : [RecommendImageInfoModel]?
    var imgInfoDatas : [RecommendImageInfoModel]? {
        set {
            _imgInfoDatas = newValue
            
            self.pagerCollectionView.reloadData()
        }
        
        get {
            return _imgInfoDatas
        }
    }
    
    // MARK: - public
    func scrollPagerDidSelectBlock(didSelectBlock : @escaping ScrollPagerDidSelectBlock) {
        self.selectBlock = didSelectBlock
    }
    
    // MARK: - collectionView dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (_imgInfoDatas?.isEmpty)! {
            return 0
        }
        return (_imgInfoDatas?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageInfoModel = _imgInfoDatas?[indexPath.row]
        let cell = RecommendPagerCell.cellWithCollectionView(collectionView: collectionView, indexPath: indexPath)
        cell.imageInfoModel = imageInfoModel
        return cell
    }
    
    // MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageInfoModel = _imgInfoDatas?[indexPath.row]
        if self.selectBlock != nil {
            self.selectBlock!(imageInfoModel?.docid!)
        }
    }
    
    // MARK: - lazy load
    lazy var pagerCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        flowLayout.itemSize = CGSize(width: 267, height: self.contentView.height)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let collectionView : UICollectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.register(RecommendPagerCell.self, forCellWithReuseIdentifier: NSStringFromClass(RecommendPagerCell.self))
        return collectionView
    }()
}
