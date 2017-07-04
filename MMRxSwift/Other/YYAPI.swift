//
//  YYAPI.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/28.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

let BaseUrl = "http://api.budejie.com/api/api_open.php"

enum YYAPI {
    case login(name: String, password: String)
    case GetNews(maxtime: String?, type: Int, page: Int)
}

extension YYAPI {
    var baseUrl: String{
        get{
            return BaseUrl
        }
    }
    
    var path: URL{
        get{
            switch self {
            case .login(_, _):
                return URL(string: baseUrl + "")!
            case .GetNews(_, _, _):
                return URL(string: baseUrl + "")!
            }
        }
    }
    
    var param: Dictionary<String, Any>{
        get{
            switch self {
            case .login(let name, let password):
                return ["name":name, "password": password]
            case .GetNews(let maxtime, let type, let page):
                return ["a":"list","c":"data","type": type, "page": page, "maxtime": maxtime ?? ""]
            }
        }
    }
    
    var method: HTTPMethod {
        get{
            switch self {
            case .login(_, _):
                return .post
            case .GetNews(_, _, _):
                return .get
            }
        }
    }
}

struct MyArray<Element>: CustomStringConvertible{
    typealias E = Element
    
    var list = [E]()
    
    mutating func push(item: E) {
        list.append(item)
    }
    
    mutating func pop() {
        list.removeLast()
    }
    
    var description: String{
        return ""
    }
}



