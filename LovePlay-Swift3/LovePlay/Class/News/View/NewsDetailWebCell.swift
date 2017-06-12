//
//  NewsDetailWebCell.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/20.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

typealias WebViewDidFinishLoadBlock = (_ webHeight : CGFloat) -> ()

class NewsDetailWebCell: UITableViewCell, UIWebViewDelegate {
    
    var finishBlock : WebViewDidFinishLoadBlock?
    
    class func cellWithTableView(tableView : UITableView) -> NewsDetailWebCell {
        let ID = NSStringFromClass(self)
        var cell : NewsDetailWebCell? = tableView.dequeueReusableCell(withIdentifier: ID) as? NewsDetailWebCell
        if cell == nil {
            cell = NewsDetailWebCell(style: .default, reuseIdentifier: ID)
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubViews()
        self.snp_subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private
    private func addSubViews() {
        self.contentView.addSubview(self.newsWebView)
    }
    
    private func snp_subViews() {
        self.newsWebView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate var _htmlBody : String?
    var htmlBody : String? {
        set {
            _htmlBody = newValue
            
            var html : String = (_htmlBody?.replacingOccurrences(of: "\t", with: ""))!
            let cssName = "News.css"
            html = "<html>" +
                    "<head><meta charset=\"UTF-8\">" +
                    "<link rel =\"stylesheet\" href =" +
                    cssName +
                    "type=\"text/css\" />" +
                    "</head>" +
                    "<body>" +
                    html +
                    "<body>" +
                   "<html>"
            let url : URL = URL.init(fileURLWithPath: Bundle.main.path(forResource: cssName, ofType: nil)!)
            self.newsWebView.loadHTMLString(html, baseURL: url)
        }
        
        get {
            
            return _htmlBody
        }
    }
    
    // MARK: - public
    func webViewDidFinishLoadBlock(finishLoadBlock : @escaping WebViewDidFinishLoadBlock) {
        self.finishBlock = finishLoadBlock
    }
    
    
    // MARK: - delegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let jsCode = "document.body.offsetHeight"
        
        let webViewHeight = Float((webView.stringByEvaluatingJavaScript(from: jsCode))!)
        
        let webHeight = CGFloat(webViewHeight!) + 10
        // update UI
        self.newsWebView.height = webHeight
        self.newsWebView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        if finishBlock != nil {
            finishBlock!(webHeight)
        }
    }
    
    // MARK: - lazy load
    lazy var newsWebView : UIWebView = {
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.contentView.width, height: 1))
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        return webView
    }()

}
