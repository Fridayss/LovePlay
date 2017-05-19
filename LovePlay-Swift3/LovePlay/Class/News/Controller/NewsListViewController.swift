//
//  NewsListViewController.swift
//  LovePlay-UIKit-Swift
//
//  Created by weiying on 2017/3/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var listDatas : [NewsListModel] = [NewsListModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubViews()
        self.loadData()
    }
    
    func addSubViews() {
        
        self.view.addSubview(tableView)
    }
    
    func loadData() {
        
        Alamofire.request("https://i.play.163.com/user/article/list/0/10").responseJSON { response in
            
//            guard let result = response.result.value else {
//                return
//            }
//            guard let resultDict = result as? [String : NSObject] else {
//                return
//            }
//            guard let info = resultDict["info"] as? [NSObject] else {
//                return
//            }
//            for dic in info{
//                print(dic)
//                let model = NewsListModel.init(dict: dic as! [String : NSObject])
//                self.listDatas.append(model)
//            }
//            self.tableView.reloadData()
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
    
    // MARK: - tableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model : NewsListModel = self.listDatas[indexPath.row]
        
//        let identifier = "cell"
//        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
//        }
//        
//        
//        cell?.textLabel?.text = model.title
//        return cell!
        let cell = NewsNormalCell.cellWithTableView(tableView: tableView)
        cell.listModel = model
        return cell
        
    }
    
    // MARK: - lazy load
    lazy var tableView : UITableView = {
        let newsTableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.estimatedRowHeight = 60
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.separatorStyle = .none
        return newsTableView
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
