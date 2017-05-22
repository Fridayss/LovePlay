//
//  RecommendViewController.swift
//  LovePlay-UIKit-Swift
//
//  Created by weiying on 2017/3/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.addSubViews()
        self.loadData()
    }
    
    private func addSubViews() {
        self.view.addSubview(collectionView)
    }
    
    private func loadData() {
        
    }
    
    // MARK: - collectionView dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ID = "collectionViewCell"
        var cell : UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath)
        if cell == nil {
            cell = UICollectionViewCell()
        }
        cell?.contentView.backgroundColor = UIColor.red
        return cell!
    }
    
    
    // MARK: - collectionView delegate

    // MARK: - lazy load
    lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
