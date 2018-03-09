//
//  VPBaseTableViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import MJRefresh
typealias VPRefreshComponentRefreshingBlock = ()->Void

class VPBaseTableViewController: VPBaseViewController {
    var _headerRefreshingBlock:VPRefreshComponentRefreshingBlock?
    var footerRefreshingBlock:VPRefreshComponentRefreshingBlock?
    let header = MJRefreshNormalHeader()
    var dataArr:NSMutableArray!
    
    lazy var tableView:UITableView  = ({ () -> UITableView in
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = UIColor.clear
        self.bgView.addSubview(tableView)
        return tableView
        }())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func  tableViewRegisterClass(cellClass:AnyClass,identifier:String) {
        self.tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
    //必须设置frame否则偏移
    func setupTableviewDelegate(delegate:Any ,frame:CGRect) {
        self.tableView.delegate = (delegate as! UITableViewDelegate)
        self.tableView.dataSource = (delegate as! UITableViewDataSource)
        self.view.frame = frame
        
    }
    var headerRefreshingBlock: VPRefreshComponentRefreshingBlock?{
        set{
            _headerRefreshingBlock = newValue
            if (self.headerRefreshingBlock != nil) {
                self.header.lastUpdatedTimeLabel.isHidden = true
                self.tableView.mj_header = self.header
                header.beginRefreshing(completionBlock: {
                    self.headerRefresh()
                })
            }
        }
        get{
            return _headerRefreshingBlock
        }
    }
    // 顶部刷新
    @objc func headerRefresh(){
        print("下拉刷新")
        self.headerRefreshingBlock!()
        // 结束刷新
        self.tableView.mj_header.endRefreshing()
        self.tableView.reloadData()
        DispatchQueue.main.async {
            if (self.dataArr.count > self.tableView.visibleCells.count) {
                if (self.tableView.mj_footer != nil){
                    self.tableView.mj_footer.isHidden = false
                }
            }else{
                if (self.tableView.mj_footer != nil){
                    self.tableView.mj_footer.isHidden = true
                }
            }
        }
        
    }
    override func initSubviews() {
        super.initSubviews()
        self.dataArr = NSMutableArray.init()
        
    }
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
        self.tableView.snp.makeConstraints {
            $0.edges.equalTo(self.bgView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
