//
//  Jokes.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/7/3.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit
import ObjectMapper

class Base: Mappable, CustomStringConvertible {
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    var description: String{
        let dic = self.toJSON()
        var str = ""
        _ = dic.map({ (key, value) -> String in
            str = "\(str)\(key): \(value) \n"
            return str
        })
        return str
    }
}

class Jokes: Base {
    
    var list: [Joke]?
    var info: JokeInfo?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        list <- map["list"]
        info <- map["info"]
    }
}

class JokeInfo: Base {
    
    var vendor: String   = ""
    var count: Int       = 0
    var page: Int        = 0
    var maxid: String    = ""
    var maxtime: String  = ""
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        vendor  <- map["vendor"]
        count   <- map["count"]
        page    <- map["page"]
        maxid   <- map["maxid"]
        maxtime <- map["maxtime"]
    }
    
}

class Joke: Base {
    
    var id: String            = ""
    var name: String          = ""
    var profile_image: String = ""
    var create_time: String   = ""
    var text: String          = ""
    var ding: Int             = 0
    var cai: Int              = 0
    var repost: Int           = 0
    var comment: Int          = 0
    var small_image: String   = ""
    var middle_image: String  = ""
    var large_image: String   = ""
    
    var cellHeight:CGFloat    = 44
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        id            <- map["id"]
        name          <- map["name"]
        profile_image <- map["profile_image"]
        create_time   <- map["create_time"]
        text          <- map["text"]
        ding          <- map["ding"]
        cai           <- map["cai"]
        repost        <- map["repost"]
        comment       <- map["comment"]
        small_image   <- map["small_image"]
        middle_image  <- map["middle_image"]
        large_image   <- map["large_image"]
    }
}
