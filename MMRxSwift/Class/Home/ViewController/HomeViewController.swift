//
//  HomeViewController.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/26.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var viewModel: JokesViewModel = JokesViewModel()
    
    deinit {
        print(#function)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ar = [1,6,9,12,15]
        let left = Tree()
        left.quan = 1
        left.bian = 0
        
        let right = Tree()
        right.quan = 3
        right.bian = 1
        
        var jie = Tree()
        jie.lft = left
        jie.rig = right
        jie.quan = left.quan + right.quan
        for i in 2..<ar.count {
            let tr = Tree()
            let fujie = Tree()
            let jise = Tree()
            jise.lft = jie.lft
            jise.rig = jie.rig
            jise.quan = jie.quan
            tr.quan = ar[i]
            if ar[i] > jise.quan {
                tr.bian = 1
                fujie.lft = jise
                fujie.rig = tr
            }
            else{
                tr.bian = 0
                fujie.rig = jise
                fujie.lft = tr
            }
            fujie.quan = jise.quan + tr.quan
            jie = fujie
        }
        yima(tree: jie)
        
        //添加子控件
        setChildView()
        //获取数据
        viewModel.getDataSource(true)
        
        //绑定刷新
        viewModel.refreshStatus
        .asObservable()
        .bind(to: tableView.rx.refreshStatus)
        .addDisposableTo(disposeBag)
        
        //绑定数据源
        viewModel.dataSource
        .asObservable()
        .bind(to: tableView.rx.items(dataSource: viewModel))
        .addDisposableTo(disposeBag)
        
        viewModel.refreshStatus
        .asObservable()
        .subscribe { (event) in
            
        }.addDisposableTo(disposeBag)
        
        //监听点击
        tableView.rx.itemSelected
        .withLatestFrom(viewModel.dataSource.asObservable()){ (indexPath, jokes) in
            return jokes[indexPath.row]
        }.subscribe { (event) in
            print(event.element?.name ?? "")
        }.addDisposableTo(disposeBag)
        
        //设置代理
        tableView.rx.setDelegate(viewModel)
        .addDisposableTo(disposeBag
        )
        
        //配置cell
        viewModel.cellConfigure = {
            (model, indexPath, table) in
            let cell = table.dequeueReusableCell(withIdentifier: "HomeViewController") as? JokeTableViewCell
            if cell == nil {
                print("---------")
            }
            cell?.selectionStyle = .none
            cell?.joke = model
            
            return cell!
        }
    }
    
    func yima(tree: Tree) {
        
        if tree.lft == nil && tree.rig == nil {
            print("\(tree.quan):\(tree.bianma)")
            return
        }
        
        if let left = tree.lft {
            
            left.bianma = tree.bianma + "0"
            yima(tree: left)
        }
        
        if let right = tree.rig {
            
            right.bianma = tree.bianma + "1"
            yima(tree: right)
        }
        
    }
    
    func setChildView(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
        
        //MJRrfresh的Block在这里需要弱引用否则会导致控制器无法释放而Rx和snp的block则不需要
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self]() in
            self?.viewModel.refresh()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self]() in
            self?.viewModel.loading()
        })
        
    }
    
    //MARK: - 属性
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "JokeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeViewController")
        tableView.separatorStyle = .none
        return tableView
    }()
}
