//
//  VPNewsVideoViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import BMPlayer
import RxSwift
import RxCocoa
class VPNewsVideoViewController: VPBaseTableViewController {
    let newsVideoCellIdentifier = "newsVideoCellIdentifier"
    private lazy var disposeBag = DisposeBag()
    var newsVideoModelArr = [VPNewsVideoModel]()
    var customPlayerView = VPNewsCustomPlayerView()
    
    /// 播放器
    lazy var player: BMPlayer = BMPlayer(customControlView: customPlayerView)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.backgroundColor = UIColor.yellow
        
        // Do any additional setup after loading the view.
    }
    override func initSubviews() {
        super.initSubviews()
        self.player.delegate = self
        self.customPlayerView.delegate = self
    
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableViewRegisterClass(cellClass: VPNewsVideoCell.self, identifier: newsVideoCellIdentifier)
        self.headerRefreshingBlock = {
            VPNetworkManager.loadNewsVideo { (pull, videoModelArr) in
                self.newsVideoModelArr = videoModelArr
                self.headerEndRefreshing()
            }
        }
        
        self.footerRefreshingBlock = {
            self.loadVideoData()
        }
        self.tableView.mj_header.beginRefreshing()
        
        
    }
    func loadVideoData() {
        VPNetworkManager.loadNewsVideo { (pull, videoModelArr) in
            if (self.newsVideoModelArr.count > 0){
                self.newsVideoModelArr = self.newsVideoModelArr + videoModelArr
            }else{
                self.newsVideoModelArr = videoModelArr
            }
            self.footerEndRefreshing()
        }
    }
    
    // MARK: - ---------------------------------- addPlayer  ----------------------------------
    func addPlayer(on cell:VPNewsVideoCell) {
        VPNetworkManager.parseVideoRealURL(video_id: cell.newsVideoModel.video_detail_info.video_id, completionHandler: { (response) in
            UIView.animate(withDuration: 0.2, animations: {
                cell.bgView.addSubview(self.player)

                let playurl = response.video_list.video_1.mainURL
                let res =  BMPlayerResource.init(url: URL.init(string: playurl)!, name: cell.newsVideoModel.title, cover: nil, subtitle: nil)
                self.player.setVideo(resource: res)
                
                
//                self.player.setVideo(resource: BMPlayerResource.init(url: URL.init(string: playurl)!))
//                self.cutomPlayerView.titleLabel.text = cell.newsVideoModel.title

                
                self.player.snp.makeConstraints {
                    $0.edges.equalTo(cell.videoPreImage)
                }
            })
            
        })
    }
    
    // MARK: - ---------------------------------- delegate ----------------------------------
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for vc in (navigationController?.viewControllers)! {
            if vc is VPNewsVideoViewController{
                if player.isPlaying{
                    let contentview = player.superview?.superview
                    let cell = contentview?.superview as! VPNewsVideoCell
                    let rect = tableView.convert(cell.frame, to: vc.view)
                    // 判断是否滑出屏幕
                    if (rect.origin.y <= -237) || (rect.origin.y >= kScreenHeight - (tabBarController?.tabBar.frame.size.height)!) {
                        VPLog("滑出屏幕")
                            self.player.pause()
                            self.player.removeFromSuperview()
                    }
                    
                }
            }
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



// MARK: - ---------------------------------- VPNewsVideoViewController UITableviewDelegate datasource ----------------------------------
extension VPNewsVideoViewController:UITableViewDelegate,UITableViewDataSource{
    //UITableviewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.newsVideoModelArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(kScreenWidth)*0.67
        return  237 //20+30+187
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
                    
                    
//                    let vpVideoDetailVC = VPNewsVideoDetailViewController()
//                    vpVideoDetailVC.index = 0
//                    vpVideoDetailVC.modalTransitionStyle = .coverVertical
//                    self?.navigationController?.present(vpVideoDetailVC, animated: false, completion: nil)
                })
                .disposed(by: disposeBag)
            
        }
        
        return cell
    }
    
}

// MARK: - ---------------------------------- BMPlayerControlViewDelegate ----------------------------------
extension VPNewsVideoViewController:BMPlayerControlViewDelegate{
    func controlView(controlView: BMPlayerControlView, didChooseDefition index: Int) {
         VPLog("didChooseDefition")
    }
    
    func controlView(controlView: BMPlayerControlView, slider: UISlider, onSliderEvent event: UIControlEvents) {
         VPLog("onSliderEvent")
    }
    
    func controlView(controlView: BMPlayerControlView, didPressButton button: UIButton) {
        
        VPLog(button)
        let vpVideoDetailVC = VPNewsVideoFullScreenViewController()
        vpVideoDetailVC.player = self.player
        vpVideoDetailVC.customPlayerView = self.customPlayerView
        
        //                    vpVideoDetailVC.modalTransitionStyle = .coverVertical
        self.navigationController?.pushViewController(vpVideoDetailVC, animated: true)
        
    }
}


// MARK: - ---------------------------------- BMPlayerDelegate ----------------------------------
extension VPNewsVideoViewController:BMPlayerDelegate{

    
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        
    }
    
}

