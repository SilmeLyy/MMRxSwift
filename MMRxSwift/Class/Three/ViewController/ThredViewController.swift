//
//  ThredViewController.swift
//  MMRxSwift
//
//  Created by 未央生 on 2017/6/26.
//  Copyright © 2017年 未央生. All rights reserved.
//

import UIKit

class ThredViewController: BaseViewController {
    
    var viewModel: ThredViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //定时器
        let time = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        
        let jishi = time.filter { (_) -> Bool in
            return !self.stopBtn.isSelected
            }.scan(0, accumulator: { (a, i)  in
                return a + 1
            }).shareReplay(1)
        
        jishi.subscribe { (event) in
            let str = self.stringFromTimeInterval(ms: event.element ?? 1)
            self.timeLable.text = str
            }.addDisposableTo(disposeBag)
        
        let lapsSequence = jishi.sample(setupBtn.rx.tap).map(stringFromTimeInterval)
            .scan([String]()) { (laptimes, newtime) in
                return laptimes + [newtime]
            }
            .shareReplay(1)
        
        //点击事件
        stopBtn.rx.tap.subscribe { (tap) in
            if self.stopBtn.isSelected {
                self.stopBtn.setTitle("暂停", for: .normal)
            }
            else{
                self.stopBtn.setTitle("开始", for: .normal)
            }
            self.stopBtn.isSelected = !self.stopBtn.isSelected
            }.addDisposableTo(disposeBag)
        
        lapsSequence.bind(to: tableView.rx.items(cellIdentifier: "ThredViewController", cellType: UITableViewCell.self)){(row,element,cell) in
            cell.textLabel?.text = element
            }.addDisposableTo(disposeBag)
        
        
        tableView.rx.modelSelected(String.self).subscribe { (event) in
            print("select\(event.element ?? "22")")
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
            }.addDisposableTo(disposeBag)
        
        addChildView()
    }
    
    func stringFromTimeInterval(ms: NSInteger) -> String {
        return String(format: "%0.2d:%0.2d.%0.1d",
                      arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
    }
    
    func addChildView() {
        view.addSubview(timeLable)
        timeLable.snp.makeConstraints({ (maker) in
            maker.left.right.equalTo(view)
            maker.top.equalTo(84)
            maker.height.equalTo(40)
        })
        
        view.addSubview(stopBtn)
        stopBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.view)
            maker.width.equalTo(kScreenWidth * 0.5)
            maker.top.equalTo(timeLable).offset(30)
            maker.height.equalTo(30)
        }
        
        view.addSubview(setupBtn)
        setupBtn.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.view)
            maker.width.equalTo(kScreenWidth * 0.5)
            maker.top.equalTo(timeLable).offset(30)
            maker.height.equalTo(30)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(self.view).offset(-49)
            maker.left.right.equalTo(self.view)
            maker.top.equalTo(self.setupBtn).offset(50)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ThredViewController")
    }
    
    
    lazy var tableView: UITableView = UITableView()
    lazy var timeLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "00:00.00"
        
        return label
    }()
    lazy var stopBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("暂停", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        return btn
    }()
    lazy var setupBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("记录", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        return btn
    }()
}


