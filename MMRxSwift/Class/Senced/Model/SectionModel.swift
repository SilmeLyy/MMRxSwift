//
//  SectionModel.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/29.
//  Copyright © 2017年 未央生. All rights reserved.
//

import Foundation

struct SectionModel<Section, ItemType>: SectionModelType, CustomStringConvertible {
    typealias Identity = Section
    typealias Item = ItemType
    
    var model: Section
    
    var identity: Section {
        return model
    }
    var items: [Item]
    
    init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
    var description: String{
        return ""
    }
    
    static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return false
    }
}
extension SectionModel{
    init(original: SectionModel<Section, Item>, items: [Item]) {
        self.model = original.model
        self.items = items
    }
}
