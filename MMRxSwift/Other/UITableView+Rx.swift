//
//  UITableView+Rx.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/7/4.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

extension Reactive where Base: UITableView {
    
    var refreshStatus: UIBindingObserver<Base, TableViewStatus>{
        return UIBindingObserver(UIElement: self.base) { tableView, status in
            switch status {
            case .None:
                tableView.mj_footer.state = .idle
                tableView.mj_header.state = .idle
            case .Refreshing:
                tableView.mj_footer.resetNoMoreData()
                tableView.mj_header.state = .refreshing
                tableView.mj_footer.state = .idle
            case .Loading:
                tableView.mj_footer.state = .refreshing
                tableView.mj_header.state = .idle
            case .NoData:
                tableView.mj_footer.state = .noMoreData
            }
        }
    }
    
}
