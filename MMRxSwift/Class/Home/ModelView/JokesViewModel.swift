//
//  JokesViewModel.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/7/4.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

enum JokeType: Int {
    case all     = 1
    case picture = 10
    case world   = 29
    case voice   = 31
    case video   = 41
}

class JokesViewModel: BaseViewObject, RxTableViewDataSourceType{
    typealias CellFactory = (Joke, IndexPath, UITableView) -> UITableViewCell
    typealias Element = [Joke]
    
    ///数据源
    var dataSource = BehaviorSubject<[Joke]>(value: [])
    var list       = [Joke]()
    private var maxtime = ""
    private var page: Int = 1
    var type: JokeType = .all
    var cellConfigure: CellFactory! = nil
    
    override init() {
        super.init()
        self.cellConfigure = { _ in
            return (nil as UITableViewCell!)!
        }
    }
    
    //刷新
    func refresh() {
        refreshStatus.value = .Refreshing
        page = 1
        getDataSource(true)
    }
    
    //加载
    func loading() {
        refreshStatus.value = .Loading
        page += 1
        getDataSource(false)
    }
    
    //获取数据
    func getDataSource(_ isRefresh: Bool) {
        NetWork.request(N: .GetNews(maxtime: maxtime, type: type.rawValue, page: page))
        .mapModel(Jokes.self)
        .map({ (jok) -> [Joke] in
            self.maxtime = jok.info?.maxtime ?? ""
            self.refreshStatus.value = .None
            return jok.list ?? []
        }).subscribe(onNext: { (jokes) in
            if isRefresh {
                self.dataSource.onNext(jokes)
            }
            else{
                let arr = self.dataSource.value
                do{
                    self.dataSource.onNext(try arr() + jokes);
                }catch{
                    self.dataSource.onError(error)
                }
            }
        }, onError: { (error) in
            self.refreshStatus.value = .None
            self.dataSource.onError(error)
        }, onCompleted: { 
            self.refreshStatus.value = .None
        }, onDisposed: { 
            
        }).addDisposableTo(disposeBag)
    }
    
    func setDataSource(_ data: [Joke]) {
        list = data
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[Joke]>) {
        setDataSource(observedEvent.element!)
        tableView.reloadData()
    }
}

extension JokesViewModel: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cellConfigure(list[indexPath.row], indexPath, tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let joke = list[indexPath.row]
        return joke.cellHeight
    }
}
