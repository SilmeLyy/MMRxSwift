//
//  RxTableViewSectionedReloadDataSource.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/29.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class RxTableViewSectionedReloadDataSource<S: SectionModelType>: TableViewSectionedDataSource<S>,RxTableViewDataSourceType {
    
    typealias Element = [S]
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[S]>) {
        UIBindingObserver(UIElement: self) { (dataSoure, section) in
            dataSoure.setSection(section.element!)
            tableView.reloadData()
        }.onNext(observedEvent)
    }
    
}
