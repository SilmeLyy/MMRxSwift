//
//  BaseViewObject.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/26.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

enum TableViewStatus {
    case None
    case Refreshing
    case Loading
    case NoData
}

class BaseViewObject: NSObject {
    let disposeBag = DisposeBag()
    
    //刷新状态
    var refreshStatus = Variable<TableViewStatus>(.None)
    
}
