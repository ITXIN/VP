//
//  VPNewsVideoDetailViewController.swift
//  VideoProject
//
//  Created by ITXX on 2018/3/7.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BMPlayer
class VPNewsVideoDetailViewController: VPBaseTableViewController {
    
    let newsVideoCellIdentifier = "newsVideoCellIdentifier"
    private lazy var disposeBag = DisposeBag()
//    var newsVideoModelArr = [VPNewsVideoModel]()
    var index:NSInteger!
    
    /// 播放器
//    lazy var player: BMPlayer = BMPlayer(customControlView: VPNewsCustomPlayerView())
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.backgroundColor = UIColor.vpGrayBgColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func initSubviews() {
        super.initSubviews()
//        self.player.delegate = self
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableViewRegisterClass(cellClass: VPNewsVideoCell.self, identifier: newsVideoCellIdentifier)
        //        self.headerRefreshingBlock = {
        //
        //
        //            }
//        self.loadVideoData()
        self.footerRefreshingBlock = {
            self.loadVideoData()
        }
        
        let _:UIButton = {
            let btn =  UIButton.init(type: UIButtonType.custom)
            self.bgView.addSubview(btn)
            btn.setImage(UIImage.init(named: "icon_navigation_back"), for: .normal)
            btn.backgroundColor = UIColor.red
            btn.layer.cornerRadius = 30/2
            btn.layer.masksToBounds = true
            btn.snp.makeConstraints{
                $0.left.equalTo(10)
                $0.top.equalTo(kStatusBarHeight)
                $0.size.equalTo(CGSize.init(width: 30, height: 30))
            }
            
            btn.addTarget(self, action:#selector(action), for: UIControlEvents.touchUpInside)
            //            btn.rx.tap.subscribe({_ in
            //                self.dismiss(animated: false, completion: nil)
            //            }).dispose()
            return btn
        }()
        
        self.player.playStateDidChange = {(isPlaying:Bool) in
            VPLog(isPlaying)
        }
        self.player.backBlock = {[unowned self] (isFullScreen) in
            if isFullScreen {
               return
            }else{
                let  _  = self.navigationController?.popViewController(animated: true)
                
            }
        }
        
        VPLog(self.player.gestureRecognizers)
    }

//    func loadVideoData() {
//        VPNetworkManager.loadNewsVideo(categary:"video") { (pull, videoModelArr) in
//            if (self.newsVideoModelArr.count > 0){
//                self.newsVideoModelArr = self.newsVideoModelArr + videoModelArr
//            }else{
//                self.newsVideoModelArr = videoModelArr
//                
//            }
//            VPLog(self.newsVideoModelArr.count)
//            
////            for  newsVideoModel  in  self.newsVideoModelArr {
////                print("abstract:"+newsVideoModel.abstract+"displayurl:"+newsVideoModel.display_url+"video_id:"+newsVideoModel.video_detail_info.video_id)
////            }
//            if (self.index == 0){
//                self.tableView.setContentOffset(CGPoint.init(x: 0, y: -kScreenHeight/2+187/2), animated: true)
//            }
//            self.footerEndRefreshing()
//        }
//    }
    
    // MARK: - ---------------------------------- addPlayer  ----------------------------------
    func addPlayer(on cell:VPNewsVideoCell) {
        guard let videoID = cell.newsVideoModel?.video_detail_info.video_id else {
            return
        }
        self.player.removeFromSuperview()
        VPNetworkManager.parseVideoRealURL(video_id: videoID, completionHandler: { (response) in
            UIView.animate(withDuration: 0.2, animations: {
                cell.bgView.addSubview(self.player)
                let playurl = response.video_list.video_1.mainURL
                self.player.setVideo(resource: BMPlayerResource.init(url: URL.init(string: playurl)!))
                self.player.snp.makeConstraints {
                    $0.edges.equalTo(cell.videoPreImage)
                }
                
            })
            
        })
    }
    
    // MARK: - ---------------------------------- UIScrollview ----------------------------------
    @objc func action(){
        //        let baseVC = VPShotVideoViewController()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - ---------------------------------- VPNewsVideoViewController UITableviewDelegate datasource ----------------------------------
extension VPNewsVideoDetailViewController:UITableViewDelegate,UITableViewDataSource{
    //UITableviewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.newsVideoModelArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return CGFloat(kScreenWidth)*0.67
        return 20+30+187
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let vpVideoDetailVC = VPNewsVideoDetailViewController()
        //        vpVideoDetailVC.modalTransitionStyle = .coverVertical
        //        self.navigationController?.pushViewController(vpVideoDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: newsVideoCellIdentifier, for: indexPath) as! VPNewsVideoCell
        if self.newsVideoModelArr.count > 0 {
            let newsVideoModel = self.newsVideoModelArr[indexPath.row]
            cell.newsVideoModel = newsVideoModel
            cell.videoPlayHudBtn.rx.tap
                .subscribe(onNext: { [weak self] in
                    VPLog("play")
                    if self!.player.isPlaying{
                        self?.player.pause()
                        self?.player.removeFromSuperview()
                    }
                    self?.addPlayer(on: cell)
                    
                })
                .disposed(by: disposeBag)
        }
        
        return cell
    }
    
}


// MARK: - ---------------------------------- BMPlayerDelegate ----------------------------------
/*
extension VPNewsVideoDetailViewController:BMPlayerDelegate{
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        VPLog("")
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //        VPLog("")
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //        VPLog("")
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        VPLog("")
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        VPLog("")
    }
    
}
*/

