//
//  VPBaseCollectionViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/16.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import MJRefresh
class VPBaseCollectionViewController: VPBaseVideoPlayerViewController {
    
    lazy var collectionView:UICollectionView  = ({ () -> UICollectionView in
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        //        flowLayout.itemSize = CGSize.init(width: (kScreenWidth-30)/2, height: 200)
        //        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        
        self.bgView.addSubview(collectionView)
        return collectionView
        }())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func  collectionViewRegisterClass(cellClass:AnyClass,identifier:String) {
        self.collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    override func initSubviews() {
        super.initSubviews()
        self.dataArr = NSMutableArray.init()
        
    }
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
        self.collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.bgView)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension VPBaseCollectionViewController{
    
    var headerRefreshingBlock: VPRefreshComponentRefreshingBlock?{
        set{
            _headerRefreshingBlock = newValue
            if (_headerRefreshingBlock != nil) {
                self.header = VPRefreshGifHeader{
                    self.headerRefresh()
                }
                self.collectionView.mj_header = self.header
                self.header.lastUpdatedTimeLabel.isHidden = true
                
            }
        }
        get{
            return _headerRefreshingBlock
        }
    }
    var footerRefreshingBlock:VPRefreshComponentRefreshingBlock?{
        set{
            _footerRefreshingBlock = newValue
            if (_footerRefreshingBlock != nil) {
                
                self.footer = MJRefreshAutoNormalFooter {
                    self.footerLoadMoreData()
                }
                self.collectionView.mj_footer = self.footer
                self.setupFooterView()
            }
        }
        get{
            return _footerRefreshingBlock
        }
    }
    
    // 顶部刷新
    @objc func headerRefresh(){
        print("下拉刷新")
        self.headerRefreshingBlock!()
    }
    
    // 加载更多
    @objc func footerLoadMoreData(){
        print("加载更多")
        self.footerRefreshingBlock!()
    }
    func headerEndRefreshing() {
        // 结束刷新
        DispatchQueue.main.async {
            self.collectionView.mj_header?.endRefreshing()
            self.collectionView.reloadData()
            self.setupFooterView()
        }
    }
    func footerEndRefreshing() {
        // 结束刷新
        DispatchQueue.main.async {
            self.collectionView.mj_footer?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    func setupFooterView() {
        if(self.collectionView.contentSize.height < 200){
            self.collectionView.mj_footer?.isHidden = true
        }else{
            self.collectionView.mj_footer?.isHidden = false
        }
    }
    func beginRefreshing() {
        self.collectionView.mj_header?.beginRefreshing()
    }
    
}
