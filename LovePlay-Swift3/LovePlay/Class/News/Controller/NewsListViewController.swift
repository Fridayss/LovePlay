//
//  NewsListViewController.swift
//  LovePlay-UIKit-Swift
//
//  Created by weiying on 2017/3/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit
import Alamofire

class NewsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
    }
    
    func loadData() {
        
        Alamofire.request("https://i.play.163.com/user/article/list/0/10").responseJSON { (response) in
            print(response.result.value as Any)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
