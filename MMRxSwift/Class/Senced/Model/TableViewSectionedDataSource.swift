//
//  TableViewSectionedDataSource.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/29.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

protocol SectionModelType {
    associatedtype Item
    
    var items: [Item] {
        get
    }
    
    init(original: Self, items: [Item])
}



class _TableViewSectionedDataSource: NSObject, UITableViewDataSource {
    
    func rx_numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rx_numberOfSections(in: tableView)
    }
    
    func rx_tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rx_tableView(_:tableView, numberOfRowsInSection:section)
    }
    
    func rx_tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (nil as UITableViewCell?)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rx_tableView(tableView, cellForRowAt: indexPath)
    }
}

class TableViewSectionedDataSource<S: SectionModelType>: _TableViewSectionedDataSource,SectionedViewDataSourceType{
    
    typealias I = S.Item
    typealias Section = S
    typealias CellFactory = (TableViewSectionedDataSource<S>, UITableView, IndexPath, I) -> UITableViewCell
    
    func model(at indexPath: IndexPath) throws -> Any {
        return indexPath
    }
    
    typealias SectionModelSnapshot = SectionModel<S, I>
    var _sectionModels: [SectionModelSnapshot] = []
    
    var sectionModels: [S] {
        return _sectionModels.map{Section(original: $0.model, items: $0.items)
        }
    }
    
    subscript(section: Int) -> S {
        let sectionModel = self._sectionModels[section]
        return S(original: sectionModel.model, items: sectionModel.items)
    }
    
    subscript(index: IndexPath) -> I {
        get{
            return _sectionModels[index.section].items[index.row]
        }
        set(item){
            var section = _sectionModels[index.section]
            section.items[index.row] = item
            self._sectionModels[index.section] = section
        }
    }
    
    func setSection(_ section: [S]){
        self._sectionModels = section.map({
            SectionModelSnapshot(model: $0, items: $0.items)
        })
    }
    
    var configureCell: CellFactory! = nil
    
    override init() {
        super.init()
        self.configureCell = { _ in
            
            return (nil as UITableViewCell!)!
        }
    }
    
    override func rx_numberOfSections(in tableView: UITableView) -> Int {
        return _sectionModels.count
    }
    
    override func rx_tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = _sectionModels[section]
        return model.items.count
    }
    
    override func rx_tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        precondition(indexPath.item < _sectionModels[indexPath.section].items.count)
        
        return configureCell(self, tableView, indexPath, self[indexPath])
    }
    
}
