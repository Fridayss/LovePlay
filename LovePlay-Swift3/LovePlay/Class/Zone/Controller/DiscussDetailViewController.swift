//
//  DiscussDetailViewController.swift
//  LovePlay
//
//  Created by Yuns on 2017/6/11.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import Alamofire

class DiscussDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var detailModel : DiscussDetailModel?
    var webViewHeight : CGFloat?
    fileprivate var _tid : String?
    var tid : String? {
        set {
            _tid = newValue
        }
        
        get {
            return _tid
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSubViews()
        self.loadData()
    }

    
    //MARK: - private
    private func addSubViews() {
        self.view.addSubview(self.tableView)
    }
    
    private func loadData() {
        let urlStr = DiscussDetailURL
        let params : [String : Any] = ["version" : "163", "module" : "viewthread", "tid": _tid!, "ppp" : "\(16)", "charset" : "utf-8", "page" : "\(1)"]
        Alamofire.request(urlStr, method: .get, parameters: params).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value as? NSDictionary {
                    print(value)
                    let variables = value["Variables"] as? NSDictionary
                    self.detailModel = DiscussDetailModel.deserialize(from: variables)
                    
                    self.tableView.reloadData()
                }
            case false:
                print(response.result.error!)
            }
        }
    }
    
    //MARK: - tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.detailModel?.postlist != nil {
            return (self.detailModel?.postlist?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post : DiscussDetailPost = (self.detailModel?.postlist![indexPath.row])!
        
        if indexPath.row == 0 {
            let webCell = DiscussDetailWebCell.cellWithTableView(tableView: tableView)
            // webView 高度为0，且内容不为空时，传入HTML内容
            if self.webViewHeight == nil {
                if let htmlBody = post.message {
                    webCell.htmlBody = htmlBody
                }
            }
            // webView 加载完成后，刷新列表
            webCell.webViewDidFinishLoadBlock(finishLoadBlock: { (webHeight) in
                self.webViewHeight = webHeight
                self.tableView.reloadData()
            })
            return webCell
        }else{
            let postCell = DiscussDetailPostCell.cellWithTableView(tableView: tableView)
            postCell.setupDiscussDetailComment(post: post, floor: indexPath.row)
            return postCell
        }
        
    }
    
    //MARK: - tableView delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if self.webViewHeight != nil {
                return self.webViewHeight!
            }
        }
        return UITableViewAutomaticDimension
    }
    
    //MARK: - setter / getter
    lazy var tableView : UITableView = {
        let detailTableView = UITableView(frame: self.view.bounds, style: .plain)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorStyle = .none
        detailTableView.estimatedRowHeight = 60
        detailTableView.rowHeight = UITableViewAutomaticDimension
        return detailTableView
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
