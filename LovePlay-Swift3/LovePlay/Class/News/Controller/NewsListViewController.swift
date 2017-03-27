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

class NewsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
    }
    
    func loadData() {
        
        Alamofire.request("https://i.play.163.com/user/article/list/0/10").responseJSON { response in
            switch response.result.isSuccess{
            case true:
                if let value = response.result.value{
                    let json = JSON(value)
                    print(json)
                }
            case false:
                print(response.result.error as Any)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
