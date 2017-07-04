//
//  RealmViewController.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/28.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class RealmViewController: BaseViewController {
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable<String>.of("111").subscribe { (event) in
            self.name = event.element ?? ""
        }.addDisposableTo(disposeBag)
        
    }


}
