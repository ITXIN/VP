//
//  VPShotVideoViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/7.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import MJRefresh
class VPShotVideoViewController: VPBaseCollectionViewController {

    let shortVideoCellIdentifier = "shortVideoCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func initSubviews() {
        super.initSubviews()
        self.bgView.backgroundColor = UIColor.vpGrayBgColor()
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.itemSize = CGSize.init(width: (kScreenWidth-30)/2, height: 200)
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionViewRegisterClass(cellClass: VPShortVideoCollectionViewCell.self, identifier: shortVideoCellIdentifier)
        self.bgView.addSubview(collectionView)
        self.collectionView.backgroundColor = UIColor.vpGrayBgColor()
        
        self.categary = "ugc_video_beauty"
        self.headerRefreshingBlock = {
            VPNetworkManager.loadNewsVideo(categary:self.categary){ (pull, videoModelArr) in
                if videoModelArr.count > 0{
                    self.newsVideoModelArr.removeAll()
                }
                self.newsVideoModelArr = videoModelArr
                self.removePlayer()
                self.headerEndRefreshing()
            }
        }
        self.beginRefreshing()
        
    }
    
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.bgView)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension VPShotVideoViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    //UICollectionDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //DFSF
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsVideoModelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shortVideoCellIdentifier, for: indexPath) as! VPShortVideoCollectionViewCell
        cell.smallVideo = self.newsVideoModelArr[indexPath.row]
        
//        cell.backgroundColor = RGB(CGFloat(100+indexPath.row*2), G: CGFloat(110+indexPath.row*2), B: (CGFloat(90+indexPath.row*2)))
        return cell
        
    }
    
    
}





