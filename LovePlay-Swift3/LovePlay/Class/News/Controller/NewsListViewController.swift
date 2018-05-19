//
//  NewsListViewController.swift
//  LovePlay-UIKit-Swift
//
//  Created by weiying on 2017/3/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftyJSON

class NewsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var listDatas : [NewsListModel] = [NewsListModel]()
    
    var _topicID : String?
    var _sourceType : Int?
    func newsListParams(topicID : String, sourceType : Int){
        _topicID = topicID
        _sourceType = sourceType
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initParams()
        self.addSubViews()
        self.loadData()
    }
    
    //MARK: - private
    private func initParams() {
        _sourceType = 1
    }
    
    private func addSubViews() {
        
        self.view.addSubview(self.tableView)
    }
    
    private func loadData() {
        var urlStr : String = BaseURL + NewsListURL + "/\(0)/\(10)"
        if _topicID != nil {
            urlStr = BaseURL + NewsListURL + "/\(_topicID!)" + "/\(0)/\(10)"
        }
        Alamofire.request(urlStr).responseJSON { response in
            switch response.result.isSuccess{
            case true:
                if let value = response.result.value as? NSDictionary {
//                    let json = JSON(value)
//                    print(value)
                    let info = value["info"] as? [NSDictionary]
                    for dict in info!{
                        let model = NewsListModel.deserialize(from: dict)
                        self.listDatas.append(model!)
                    }
                    
                    self.tableView.reloadData()
                }
            case false:
                print(response.result.error as Any)
            }
        }
    }
    
    // MARK: - tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel : NewsListModel = self.listDatas[indexPath.row]
        if _sourceType == 0 {
            let cell = NewsImageTitleCell.cellWithTableView(tableView: tableView)
            cell.listModel = listModel
            return cell
        }else{
            if listModel.showType.intValue == 2 {
                let cell = NewsTitleImageCell.cellWithTableView(tableView: tableView)
                cell.listModel = listModel
                return cell
            }else{
                let cell = NewsNormalCell.cellWithTableView(tableView: tableView)
                cell.listModel = listModel
                return cell
            }
        }
    }
    
    // MARK: - tableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : NewsListModel = self.listDatas[indexPath.row]
        let detaiViewController = NewsDetailViewController.init(newsID: model.docid)
        self.navigationController?.pushViewController(detaiViewController, animated: true)
    }
    
    // MARK: - lazy load
    lazy var tableView : UITableView = {
        let newsTableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.separatorStyle = .none
        newsTableView.estimatedRowHeight = 60
        newsTableView.rowHeight = UITableViewAutomaticDimension
        
        return newsTableView
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
