//
//  DiscussListViewController.swift
//  LovePlay
//
//  Created by weiying on 2017/6/6.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import Alamofire

class DiscussListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var discussListDatas : [DiscussListModel]? = [DiscussListModel]()
    var discussListTopDatas : [DiscussListModel]? = [DiscussListModel]()
    
    fileprivate var _fid : String?
    var fid : String? {
        set {
            _fid = newValue
        }
        
        get {
            return _fid
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubViews()
        self.loadData()
    }
    
    //MARK: - private
    func addSubViews() {
        self.view.addSubview(self.tableView)
    }
    
    func loadData() {
        self.loadListData()
    }
    
    func loadListData() {
        let params : [String : Any] = ["version":"163", "module":"forumdisplay", "fid":_fid!, "tpp":"15", "charset":"utf-8", "page": "1"]
        let urlStr = DiscussListURL
        Alamofire.request(urlStr, method: .get, parameters: params).responseJSON { (response) in
            switch response.result.isSuccess {
            case true :
                print(response.result.value!)
                if let value = response.result.value as? NSDictionary {
                    let variables = value["Variables"] as? NSDictionary
                    let forum_threadlist = variables?["forum_threadlist"] as? [NSDictionary]
                    var discussList : [DiscussListModel]? = [DiscussListModel]()
                    for dict in forum_threadlist! {
                        let listModel  = DiscussListModel.deserialize(from: dict)
                        discussList?.append(listModel!)
                    }
                    //区分列表数据
                    self.sectionDiscussList(discussList: discussList!)
                    //刷新列表
                    self.tableView.reloadData()
                }
            case false :
                print(response.result.error!)
            }
        }
    }
    
    func loadImgData() {
        
    }
    
    func sectionDiscussList(discussList : [DiscussListModel]) {
        for listModel in discussList {
            if listModel.displayorder == 1 {
                self.discussListDatas?.append(listModel)
            }else{
                self.discussListDatas?.append(listModel)
            }
        }
    }
    
    //MARK: - tableView dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if (self.discussListTopDatas?.isEmpty)! {
                return 0
            }
            return (self.discussListTopDatas?.count)!
        case 1:
            if (self.discussListDatas?.isEmpty)! {
                return 0
            }
            return (self.discussListDatas?.count)!
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell : DiscussListTopCell = DiscussListTopCell.cellWithTableView(tableView: tableView)
            return cell
        case 1:
            let cell : DiscussListCell = DiscussListCell.cellWithTableView(tableView: tableView)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    //MARK: - tableView delegate
    
    //MARK: - setter / getter
    lazy var tableView : UITableView = {
        let tableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        return tableView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
