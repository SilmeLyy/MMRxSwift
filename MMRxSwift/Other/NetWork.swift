//
//  NetWork.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/30.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

enum YYError: Error {
    case ResponseError
    case ToModelError
}

struct YYResult {
    var data: Any?
}

class NetWork: NSObject {
    
    static func request(N: YYAPI) -> Observable<YYResult> {
        return Observable<YYResult>.create { (obser) -> Disposable in
            Alamofire.request(N.path, method: N.method, parameters: N.param, encoding: URLEncoding.default, headers: nil)
                .responseJSON(completionHandler: { (response) in
                    var result = YYResult()
                    switch response.result{
                    case .success(let value):
                        result.data = value
                        obser.onNext(result)
                    case .failure(let error):
                        obser.onError(error)
                    }
                })
            return Disposables.create()
        }
    }
    
}

extension Observable where E == YYResult {
    func mapModel<T: Mappable>(_ type: T.Type) -> Observable<T> {
        return self.map { result  in
            guard let dict = result.data as? [String: Any] else {
                throw YYError.ToModelError
            }
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
    func mapArrModel<T: Mappable>(_ Type: T.Type) -> Observable<[T]>{
        return self.map { (result) in
            guard let array = result.data as? [Any] else {
                throw YYError.ToModelError
            }
            guard let dicts = array as? [[String: Any]] else {
                throw YYError.ToModelError
            }
            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }
}
