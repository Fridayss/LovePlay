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
    var newsID : String?
    
    init(newsID : String) {
        super.init(nibName: nil, bundle: nil)
        self.newsID = newsID;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSubViews()
        self.loadData()
    }
    
    // MAR: - private
    private func addSubViews() {
        
        self.view.addSubview(self.tableView)
    }
    
    private func loadData() {
        let urlStr = BaseURL + NewsDetailURL + "/\(self.newsID!)"
        let params : [String : Any] = ["tieVersion" : "v2", "platform" : "ios", "width" : self.view.width * 2, "height" : self.view.height * 2, "decimal" : "75"]
        Alamofire.request(urlStr, method : .get, parameters : params).responseJSON { response in
            switch response.result.isSuccess{
            case true:
                if let value = response.result.value as? NSDictionary{
                    let info = value["info"] as? NSDictionary
                    if let detailModel = NewsDetailModel.deserialize(from: info) {
                        
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
            if self.detailModel?.tie?.commentIdsSB != nil {
                return (self.detailModel?.tie?.commentIdsSB!.count)!
            }
            return 0
        case 2:
            if self.detailModel?.article?.relative_sys != nil {
                return (self.detailModel?.article?.relative_sys?.count)!
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
            // webView 高度为0，且内容不为空时，传入HTML内容
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
        case 1:
            let commentCell : NewsCommentCell = NewsCommentCell.cellWithTableView(tableView: tableView)
            let floors = (self.detailModel?.tie?.commentIdsSB![indexPath.row]) as! NSArray
            commentCell.setupComment(commentItems: (self.detailModel?.tie?.commentsSB)!, commmentIds: floors)
            return commentCell
        case 2:
            let relativeCell : NewsRelativeCell = NewsRelativeCell.cellWithTableView(tableView: tableView)
            relativeCell.relativeModel = self.detailModel?.article?.relative_sys?[indexPath.row]
            return relativeCell
        default:
            return UITableViewCell()
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
        case 1:
            if self.detailModel?.tie?.commentIdsSB?.count != 0 {
                return 30
            }
            return CGFloat.leastNormalMagnitude
        case 2:
            if self.detailModel?.article?.relative_sys?.count != 0 {
               return 30
            }
            return CGFloat.leastNormalMagnitude
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            if self.detailModel?.tie?.commentIdsSB?.count != 0 {
                return 40
            }
             return CGFloat.leastNormalMagnitude
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = NewsSectionHeaderView.sectionHeaderWithTableView(tableView: tableView)
        switch section {
        case 1:
            if self.detailModel?.tie?.commentIdsSB?.count != 0 {
                header.titleText = "热门跟帖"
                return header
            }
            return nil
        case 2:
            if self.detailModel?.article?.relative_sys?.count != 0 {
                header.titleText = "猜你喜欢"
                return header
            }
            return nil
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if 1 == section {
            if self.detailModel?.tie?.commentIdsSB?.count != 0 {
                let footer = NewsCommentFooterView.sectionHeaderWithTableView(tableView: tableView)
                footer.titleText = "查看更多跟帖"
                footer.commentFooterClickBlock {
                    let commentViewController = NewsCommentViewController()
                    commentViewController.newsID = self.newsID!
                    self.navigationController?.pushViewController(commentViewController, animated: true)
                }
                return footer
            }
            return nil
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let relativeModel : DetailRelativeModel = (self.detailModel?.article?.relative_sys?[indexPath.row])!
            let detailViewContrller = NewsDetailViewController.init(newsID: relativeModel.docID!)
            self.navigationController?.pushViewController(detailViewContrller, animated: true)
        }
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
