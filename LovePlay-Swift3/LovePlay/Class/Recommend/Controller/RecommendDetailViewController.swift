//
//  RecommendDetailViewController.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/30.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class RecommendDetailViewController: UIViewController {

    var _topicID : String?
    var _sourceType : Int?
    init(topicID : String, sourceType : Int){
        super.init(nibName: nil, bundle: nil)
        _topicID = topicID
        _sourceType = sourceType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNewsListViewController()
    }
    
    // MARK: - private
    func addNewsListViewController() {
        let listViewController : NewsListViewController = NewsListViewController()
        listViewController.newsListParams(topicID: _topicID!, sourceType: _sourceType!)
        self.addChildViewController(listViewController)
        self.view.addSubview(listViewController.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
