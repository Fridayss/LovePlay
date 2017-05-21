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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubViews()
        self.loadData()
    }
    
    private func addSubViews() {
        
        self.view.addSubview(tableView)
    }
    
    private func loadData() {
        let urlStr = BaseURL + NewsListURL + "/\(0)/\(10)"
        Alamofire.request(urlStr).responseJSON { response in
            switch response.result.isSuccess{
            case true:
                if let value = response.result.value as? [String : AnyObject]{
//                    let json = JSON(value)
//                    print(json)
                    let info = value["info"] as? [NSObject]
                    for dict in info!{
                        print(dict)
                        let model = NewsListModel.init(dict: dict as! [String : NSObject])
                        self.listDatas.append(model)
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
        let model : NewsListModel = self.listDatas[indexPath.row]
        let cell = NewsNormalCell.cellWithTableView(tableView: tableView)
        cell.listModel = model
        return cell
        
    }
    
    // MARK: - tableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : NewsListModel = self.listDatas[indexPath.row]
        let detaiViewController = NewsCommentViewController()
        detaiViewController.newsID = model.docid
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