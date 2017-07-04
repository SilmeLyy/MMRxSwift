//
//  ViewController.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/26.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let accStr = accountTextField.rx.text.map{ str -> Bool in
            return (str?.characters.count)! >= 6
        }
        let passStr = passwordTextField.rx.text.map{ str -> Bool in
            return (str?.characters.count)! >= 6
        }
        
        accStr.bind(to: passwordTextField.rx.isEnabled)
        .addDisposableTo(disposeBag)
        
        let log = Observable.combineLatest(accStr, passStr) { (acc, pass) -> Bool in
            return acc && pass
        }
        
        log.bind(to: loginBtn.rx.isEnabled)
        .addDisposableTo(disposeBag)
        
//        loginBtn.rx.controlEvent(.touchUpInside).asObservable().subscribe { (ev) in
//            print("---\(ev)")
//        }.addDisposableTo(disposeBag)
        
        loginBtn.rx.tap.subscribe{ _ in
            self.present(BaseTabBarViewController(), animated: true, completion: nil)
        }.addDisposableTo(disposeBag)
    }
}

