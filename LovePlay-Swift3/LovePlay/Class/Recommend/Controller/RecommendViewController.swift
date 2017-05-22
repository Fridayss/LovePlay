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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.addSubViews()
        self.loadData()
    }
    
    private func addSubViews() {
        self.view.addSubview(recommendCollectionView)
    }
    
    private func loadData() {
        self.loadTopicData()
    }
    
    private func loadTopicData() {
        let urlStr = BaseURL + RecommendTopicURL
        Alamofire.request(urlStr).response { (response) in
            
        }
    }
    
    private func loadImageInfoData() {
        let urlStr = BaseURL + RecommendImageInfosURL
        Alamofire.request(urlStr).response { (response) in
            
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if 0 == indexPath.section {
            let cell = RecommendScrollCell.cellWithCollectionView(collectionView: collectionView, indexPath: indexPath)
            return cell
        }
        let cell = RecommendTopicCell.cellWithCollectionView(collectionView: collectionView, indexPath: indexPath)
        return cell
    }
    
    // MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (0 == indexPath.section) && (kind == UICollectionElementKindSectionFooter) {
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "sectionFooterID", for: indexPath)
            sectionFooter.backgroundColor = UIColor.lightGray
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

    // MARK: - lazy load
    lazy var recommendCollectionView : UICollectionView = {
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
