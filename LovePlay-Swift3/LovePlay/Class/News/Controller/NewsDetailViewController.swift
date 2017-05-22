//
//  NewsDetailViewController.swift
//  LovePlay
//
//  Created by weiying on 2017/5/19.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import Alamofire

class NewsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var detailModel : NewsDetailModel?
    var webViewHeight : CGFloat?
    fileprivate var _newsID : String?
    var newsID : String? {
        set {
            _newsID = newValue
        }
        
        get {
            return _newsID
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSubViews()
        self.loadData()
    }
    
    // MAR: - private
    private func addSubViews() {
        
        self.view.addSubview(tableView)
    }
    
    private func loadData() {
        let urlStr = BaseURL + NewsDetailURL + "/\("C72979E100314V88")"
        Alamofire.request(urlStr).responseJSON { response in
            switch response.result.isSuccess{
            case true:
                if let value = response.result.value as? NSDictionary{
                    let info = value["info"] as? NSDictionary
                    if let detailModel = NewsDetailModel.deserialize(from: info){
                        
                        print((detailModel.article?.title)!)
                        
                        self.detailModel = detailModel
                    }
                    self.tableView.reloadData()
                }
            case false:
                print(response.result.error as Any)
            }
        }
    }
    
    
    // MARK: - tableView dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        case 2:
            if (self.detailModel?.article?.relative_sys) != nil {
                return (self.detailModel?.article?.relative_sys)!.count
            }
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let webCell : NewsDetailWebCell = NewsDetailWebCell.cellWithTableView(tableView: tableView)
            // webView 高度为0，且内容不为空时，传入
            if self.webViewHeight == nil {
                if let htmlBody = self.detailModel?.article?.body {
                    webCell.htmlBody = htmlBody
                }
            }
            // webView 加载完成后，刷新列表
            webCell.webViewDidFinishLoadBlock(finishLoadBlock: { (webHeight) in
                self.webViewHeight = webHeight
                self.tableView.reloadData()
            })
            return webCell
            
        case 2 :
            let relativeCell : NewsRelativeCell = NewsRelativeCell.cellWithTableView(tableView: tableView)
            relativeCell.relativeModel = self.detailModel?.article?.relative_sys?[indexPath.row]
            return relativeCell
        default:
            let ID = "cell"
            var cell : UITableViewCell?
            cell = tableView.dequeueReusableCell(withIdentifier: ID)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: ID)
            }
            cell?.textLabel?.text = "heheheh"
            return cell!
        }
    }
    
    // MARK: - tableView delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if self.webViewHeight != nil {
                return self.webViewHeight!
            }
            return UITableViewAutomaticDimension
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 30
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 40
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = NewsSectionHeaderView.sectionHeaderWithTableView(tableView: tableView)
        switch section {
        case 2:
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = NewsCommentFooterView.sectionHeaderWithTableView(tableView: tableView)
        return footer
    }
    
    // MARK: - lazy load
    lazy var tableView : UITableView = {
        let detailTableView = UITableView(frame: self.view.bounds, style: .grouped)
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
