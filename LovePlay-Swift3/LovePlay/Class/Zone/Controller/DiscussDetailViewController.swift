//
//  DiscussDetailViewController.swift
//  LovePlay
//
//  Created by Yuns on 2017/6/11.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class DiscussDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //MARK: - private
    private func addSubViews() {
    
    }
    
    private func loadData() {
    
    }
    
    //MARK: - tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    //MARK: - tableView delegate
    
    //MARK: - setter / getter
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
