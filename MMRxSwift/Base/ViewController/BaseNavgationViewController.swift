//
//  BaseNavgationViewController.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/26.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class BaseNavgationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self as? UINavigationControllerDelegate
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
extension BaseViewController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
}
