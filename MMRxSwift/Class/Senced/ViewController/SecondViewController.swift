//
//  SecondViewController.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/26.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let dataSoure = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>()
        let items = Observable.of([
            SectionModel<String, String>(model: "one", items:["one","two"]),
            SectionModel<String, String>(model: "two", items:["one","two"]),
            SectionModel<String, String>(model: "two", items:["one","two"])])
        
        dataSoure.configureCell = { (data, tb, indexPath, item) in
            let cell = tb.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = item
            return cell
        }
        
        items.bind(to: tableView.rx.items(dataSource: dataSoure))
            .disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.withLatestFrom(items){
            (i, viewModel) -> String in
            return viewModel[i.section].items[i.row]
        }.subscribe { (event) in
            print(event.element ?? "")
        }.addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self)
            .addDisposableTo(disposeBag)
        
    }
    
    var tableView = UITableView()
}

extension SecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
}
