//
//  ZoneListViewController.swift
//  LovePlay-UIKit-Swift
//
//  Created by weiying on 2017/3/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import Alamofire

class ZoneListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var zoneDatas : [ZoneListModel]? = [ZoneListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSubViews()
        self.loadData()
    }

    // MARK: - private
    private func addSubViews() {
        self.view.addSubview(self.colletionView)
    }
    
    private func loadData() {
        let urlStr = BaseURL + ZoneDiscussURL
        Alamofire.request(urlStr).responseJSON { (response) in
            print(response)
            switch response.result.isSuccess {
            case true :
                if let value = response.result.value as? NSDictionary {
                    let info = value["info"] as? NSDictionary
                    let discuzList = info?["discuzList"] as? [NSDictionary]
                    for detailList in discuzList! {
                        let listModel = ZoneListModel.deserialize(from: detailList)
                        self.zoneDatas?.append(listModel!)
                    }
                    
                    self.colletionView.reloadData()
                }
            case false :
                print(response.result.error!)
            }
        }
    }
    
    // MARK: - collectionView dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (self.zoneDatas?.isEmpty)! {
            return 0
        }
        return (self.zoneDatas?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let detailList = self.zoneDatas?[section].detailList {
            return detailList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ZoneListCell.cellWithCollectionView(collectionView: collectionView, indexPath: indexPath)
        let detailList = self.zoneDatas?[indexPath.section].detailList
        let discussItem = detailList?[indexPath.row]
        cell.listModel = discussItem
        return cell
    }
    
    // MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let listModel = self.zoneDatas?[indexPath.section]
            let sectionHeader : ZoneListSectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(ZoneListSectionHeader.self), for: indexPath) as! ZoneListSectionHeader
            sectionHeader.titleTextLabel.text = listModel?.type?.typeName
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.size.width, height: 30)
    }
    
    // MARK: - setter / getter
    lazy var colletionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (self.view.bounds.size.width - 1) / 2, height: 70.0)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        let colletionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        colletionView.backgroundColor = RGB(r: 245, g: 245, b: 245)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.alwaysBounceVertical = true
        colletionView.register(ZoneListCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZoneListCell.self))
        colletionView.register(ZoneListSectionHeader.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: NSStringFromClass(ZoneListSectionHeader.self))
        return colletionView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
