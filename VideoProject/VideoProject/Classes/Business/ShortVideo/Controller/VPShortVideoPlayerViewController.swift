//
//  VPShortVideoPlayerViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/17.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import BMPlayer
class VPShortVideoPlayerViewController: VPBaseVideoPlayerViewController {
    
    var scrooToIndex:IndexPath!
    var collectionView:UICollectionView!
    let shortVideoPlayerCellIdentifier = "shortVideoPlayerCellIdentifier"
    var backBtn:UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if scrooToIndex.row != 0 {
            collectionView.scrollToItem(at: scrooToIndex, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
        self.setupPlayer(index: scrooToIndex.row)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func initSubviews() {
        super.initSubviews()
        self.automaticallyAdjustsScrollViewInsets = false
        customPlayerView = VPShortVideoCustomPlayerView()
        player = BMPlayer(customControlView: customPlayerView)
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = CGSize.init(width: kScreenWidth, height: kScreenHeight)
        flowLayout.minimumLineSpacing = 0.0//这个要设置否则偏移
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VPShortVideoCollectionViewCell.self, forCellWithReuseIdentifier: shortVideoPlayerCellIdentifier)
        collectionView.isPagingEnabled = true
        self.bgView.addSubview(collectionView)
        self.collectionView.backgroundColor = UIColor.vpGrayBgColor()
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        backBtn = ({ () -> UIButton in
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.bgView.addSubview(btn)
            btn.setImage(UIImage.init(named: "icon_navigation_back"), for: .normal)
            btn.backgroundColor = UIColor.vpThemColor()
            btn.layer.cornerRadius = 30/2
            btn.layer.masksToBounds = true
            btn.snp.makeConstraints{
                $0.left.equalTo(10)
                $0.top.equalTo(kStatusBarAndNavigationBarHeight-30)
                $0.size.equalTo(CGSize.init(width: 30, height: 30))
            }
            btn.addTarget(self, action: #selector(backRootVC), for: .touchUpInside)
            
            return btn
            }())
        
    }
    @objc func backRootVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
        self.collectionView.snp.makeConstraints {
            
            //            if (kiPhoneX){
//            $0.top.equalTo(kNavigationBarHeight)
//            $0.left.equalTo(0)
//            $0.right.equalTo(0)
//            $0.bottom.equalTo(0)
            //            }else{
            $0.edges.equalTo(self.bgView)
            //            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension VPShortVideoPlayerViewController{
    
    func setupPlayer(index:Int)  {
        
        guard  let smallVideo = self.newsVideoModelArr[index] else {
            return
        }
    
        if  let videoURLStr = smallVideo.raw_data.video.play_addr.url_list.first             {
           
            let dataTask = URLSession.shared.dataTask(with: URL.init(string: videoURLStr)!, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    self.customPlayerView.replayButton.isHidden = true
                    self.removePlayer()
                    let cell = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! VPShortVideoCollectionViewCell
                    cell.bgView.insertSubview(self.player, belowSubview: cell.titleLab)
                    self.player.snp.makeConstraints({ $0.edges.equalTo(cell.bgView) })
                    
                    
                    let asset = BMPlayerResource(url: URL(string: response!.url!.absoluteString)!)
                    self.player.setVideo(resource: asset)
                    self.player.autoPlay()
                }
            })
            dataTask.resume()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let  offset  = Int(scrollView.contentOffset.x/kScreenWidth)
        print("offset",offset)
        self.setupPlayer(index: offset)
    }
    
    
}

extension VPShortVideoPlayerViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //UICollectionDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsVideoModelArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shortVideoPlayerCellIdentifier, for: indexPath) as! VPShortVideoCollectionViewCell
        cell.setupPlayerSubviewsLayout()
        guard let video = self.newsVideoModelArr[indexPath.row] else {
            return cell
        }
        cell.smallVideo = video
     
        
        return cell
        
    }
}

