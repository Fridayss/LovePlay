//
//  MainTabBarController.swift
//  LovePlay
//
//  Created by weiying on 2017/3/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNewsViewController()
        self.addRecommendViewController()
        self.addZoneViewController()
    }

    func configureTabBar() {
        
        
        
    }
    
    func addNewsViewController(){
        let newsVC = NewsListViewController()
        
        self.addChildIntoTabBarController(childController: newsVC, title: "资讯", imageName: "icon_zx_nomal_pgall", selectImageName: "icon_zx_pressed_pgall")
    }
    
    func addRecommendViewController(){
        let newsVC = RecommendViewController()
        
        self.addChildIntoTabBarController(childController: newsVC, title: "精选", imageName: "icon_jx_nomal_pgall", selectImageName: "icon_jx_pressed_pgall")
    }
    
    func addZoneViewController(){
        let newsVC = NewsListViewController()
        
        self.addChildIntoTabBarController(childController: newsVC, title: "社区", imageName: "icon_sq_nomal_pgall", selectImageName: "icon_sq_pressed_pgall")
    }
    
    
    func addChildIntoTabBarController(childController : UIViewController, title : String, imageName : String, selectImageName : String) {
        childController.title = title
        childController.tabBarItem.title = title;
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectImageName)
        
        let childNav = MainNavigationController(rootViewController: childController)
        self.addChildViewController(childNav)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
