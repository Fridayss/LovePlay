//
//  RecommendViewController.swift
//  LovePlay-UIKit-Swift
//
//  Created by weiying on 2017/3/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import Alamofire

class RecommendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var topicDatas : [RecommendTopicModel] = [RecommendTopicModel]()
    var imgInfoDatas : [RecommendImageInfoModel] = [RecommendImageInfoModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.addSubViews()
        self.loadData()
    }
    
    private func addSubViews() {
        self.view.addSubview(self.collectionView)
    }
    
    private func loadData() {
        self.loadTopicData()
        self.loadImageInfoData()
    }
    
    private func loadTopicData() {
        let urlStr = BaseURL + RecommendTopicURL
        Alamofire.request(urlStr).responseJSON { (response) in
//            print(response)
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value as? NSDictionary {
                    let info = value["info"] as? [NSDictionary]
                    for dict in info! {
                        let topicModel = RecommendTopicModel.deserialize(from: dict)
                        self.topicDatas.append(topicModel!)
                    }
                    
                    self.collectionView.reloadData()
                }
            case false:
                print(response.result.error as Any)
            }
        }
    }
    
    private func loadImageInfoData() {
        let urlStr = BaseURL + RecommendImageInfosURL
        Alamofire.request(urlStr).responseJSON { (response) in
            print(response)
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value as? NSDictionary {
                    let info = value["info"] as? [NSDictionary]
                    for dict in info! {
                        let imgInfoModel = RecommendImageInfoModel.deserialize(from: dict)
                        self.imgInfoDatas.append(imgInfoModel!)
                    }
                    
                    self.collectionView.reloadData()
                }
            case false:
                print(response.result.error as Any)
            }
        }
    }
    
    // MARK: - collectionView dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if 0 == section {
            return 1
        }
        return self.topicDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if 0 == indexPath.section {
            let cell = RecommendScrollCell.cellWithCollectionView(collectionView: collectionView, indexPath: indexPath)
            cell.scrollPagerDidSelectBlock(didSelectBlock: { (docID) in
                
                
            })
            cell.imgInfoDatas = self.imgInfoDatas
            return cell
        }
        let topicModel = self.topicDatas[indexPath.row]
        let cell = RecommendTopicCell.cellWithCollectionView(collectionView: collectionView, indexPath: indexPath)
        cell.topicModel = topicModel
        return cell
    }
    
    // MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (0 == indexPath.section) && (kind == UICollectionElementKindSectionFooter) {
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "sectionFooterID", for: indexPath)
            sectionFooter.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
            return sectionFooter
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if 0 == section {
            return CGSize(width: self.view.width, height: 6)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if 0 == indexPath.section {
            return CGSize(width: self.view.width, height: 112)
        }
        return CGSize(width: 80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsetsMake(15, 0, 15, 0)
        case 1:
            return UIEdgeInsetsMake(15, 15, 15, 15)
        default:
            return UIEdgeInsets.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topicModel = self.topicDatas[indexPath.row]
        let detailViewContrller = RecommendDetailViewController.init(topicID: topicModel.topicId!, sourceType: topicModel.sourceType!)
        detailViewContrller.title = topicModel.topicName
        self.navigationController?.pushViewController(detailViewContrller, animated: true)
    }

    // MARK: - lazy load
    lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(RecommendTopicCell.self, forCellWithReuseIdentifier:NSStringFromClass(RecommendTopicCell.self))
        collectionView.register(RecommendScrollCell.self, forCellWithReuseIdentifier:NSStringFromClass(RecommendScrollCell.self))
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "sectionFooterID")
        return collectionView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
