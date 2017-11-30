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
    var profile_image: String = "www.baidu.com"{
        didSet{
            urlProfileImage = URL(string: profile_image)!
        }
    }
    var urlProfileImage: URL!
    var create_time: String   = ""
    var text: String          = ""
    var ding: String          = ""
    var cai: String           = ""
    var repost: String        = ""
    var comment: String       = ""
    var image0: String        = ""
    var image1: String        = ""
    var image2: String        = "www.baidu.com"{
        didSet{
            image2Url = URL(string: image2)!
        }
    }
    var image2Url: URL!
    var type: String          = "1"{
        didSet{
            typeInt = Int(type)!
        }
    }
    var typeInt: Int          = 1
    var isBigPic: Bool        = false
    var width: String         = "0"
    var height: String        = "0"
    var textHeight:CGFloat    = 0
    var cellHeight:CGFloat{
        get{
            var contentHeight: CGFloat = 55
            let maxWidth = kScreenWidth - 20
            textHeight = text.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)], context: nil).size.height
            contentHeight += textHeight
            let Fwidth = CGFloat(Float(width)!)
            let Fheight = CGFloat(Float(height)!)
            
            if typeInt == 10 {
                let picHeight = maxWidth * Fheight / Fwidth
                pictureFrame = CGRect(x: 10, y: 55 + textHeight, width: maxWidth, height: picHeight)
                if picHeight >= 1000 {
                    pictureFrame.size.height = 1000
                    isBigPic = true
                }
                contentHeight += pictureFrame.height + 10
            }
            else if typeInt == 31 {
                let picHeight = maxWidth * Fheight / Fwidth
                pictureFrame = CGRect(x: 10, y: 55 + textHeight, width: maxWidth, height: picHeight)
                contentHeight += pictureFrame.height + 10
            }
            else if typeInt == 41 {
                let picHeight = maxWidth * Fheight / Fwidth
                pictureFrame = CGRect(x: 10, y: 55 + textHeight, width: maxWidth, height: picHeight)
                contentHeight += pictureFrame.height + 10
            }
            
            return contentHeight + 60
        }
    }
    var pictureFrame: CGRect   = CGRect.zero
    
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
        image0        <- map["image0"]
        image1        <- map["image1"]
        image2        <- map["image2"]
        type          <- map["type"]
        height        <- map["height"]
        width         <- map["width"]
    }
}
