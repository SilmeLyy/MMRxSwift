//
//  BaseTabBarViewController.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/26.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = HomeViewController()
        creatChildViewController(VC: home, orIamage: UIImage(named: "Home")!, selectImage: UIImage(named: "Home蓝")!, title: "主页")
        
        let second = SecondViewController()
        creatChildViewController(VC: second, orIamage: UIImage(named: "Grid灰")!, selectImage: UIImage(named: "Grid")!, title: "分类")
        
        let thred = ThredViewController()
        creatChildViewController(VC: thred, orIamage: UIImage(named: "search")!, selectImage: UIImage(named: "searchBlue")!, title: "搜索")
    }
    
    func creatChildViewController(VC: UIViewController, orIamage: UIImage, selectImage: UIImage, title: String){
        
        VC.tabBarItem.image = orIamage
        VC.tabBarItem.selectedImage = selectImage
        VC.title = title
        let nav = BaseNavgationViewController(rootViewController: VC)
        
        self.addChildViewController(nav)
    }

}
