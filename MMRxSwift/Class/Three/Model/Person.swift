//
//  Person.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/28.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

struct Person: Mappable {
    
    var name: String     = ""
    var age: Int         = 0
    var adress: String   = ""
    
    
    init?(map: Map) {
        
    }
    
    init(name: String, age: Int, adress: String) {
        self.name = name;
        self.age = age
        self.adress = adress
    }
    
    mutating func mapping(map: Map) {
        
    }
    
}
