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
    var currentCell:VPNewsVideoCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.backgroundColor = UIColor.vpGrayBgColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func initSubviews() {
        super.initSubviews()
        customPlayerView = VPNewsCustomPlayerView()
        player = BMPlayer(customControlView: customPlayerView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableViewRegisterClass(cellClass: VPNewsVideoCell.self, identifier: newsVideoCellIdentifier)
        self.categary = "video"
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
        
        self.footerRefreshingBlock = {
            self.loadVideoData()
        }
        
        self.beginRefreshing()
    }
    
    // MARK: - ---------------------------------- addPlayer  ----------------------------------
    func addPlayer(on cell:VPNewsVideoCell) {
        VPNetworkManager.parseVideoRealURL(video_id: cell.newsVideoModel.video_detail_info.video_id, completionHandler: { (response) in
            UIView.animate(withDuration: 0.2, animations: {
                self.currentCell = cell
                self.removePlayer()
                cell.bgView.addSubview(self.player)
                self.player.delegate = self
                
                self.customPlayerView.delegate = self
                self.customPlayerView.replayButton.isHidden = true;
                self.customPlayerView.chooseDefitionView.isHidden = true
                
                let playurl = response.video_list.video_1.mainURL
                let res =  BMPlayerResource.init(url: URL.init(string: playurl)!, name: cell.newsVideoModel.title, cover: nil, subtitle: nil)
                self.player.setVideo(resource: res)
            
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
                    let cell = self.currentCell
                    let rect = tableView.convert((cell?.frame)!, to: vc.view)
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        VPLog("viewWillTransition")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



// MARK: - ---------------------------------- VPNewsVideoViewController UITableviewDelegate datasource ----------------------------------
extension VPNewsVideoViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.newsVideoModelArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        return CGFloat(kScreenWidth)*0.67
        return  237
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
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
                        self?.removePlayer()
                        
                    }
                    self?.addPlayer(on: cell)
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
        
         controlView.player?.controlView(controlView: controlView, didPressButton: button)
        
        if let action = BMPlayerControlView.ButtonType(rawValue: button.tag) {
            switch action {
            case .fullscreen:

                self.player.delegate = nil
                self.customPlayerView.delegate = nil
                let vpVideoDetailVC = VPNewsVideoFullScreenViewController()
                vpVideoDetailVC.modalTransitionStyle = .crossDissolve
                vpVideoDetailVC.modalPresentationStyle = .fullScreen
                vpVideoDetailVC.player = self.player
                vpVideoDetailVC.customPlayerView = self.customPlayerView as! VPNewsCustomPlayerView!
            
                
                vpVideoDetailVC.playerBackBlock = { (fullScreenPlayer,currentTime,fullScreenCustomPlayerView)in
                   
                    self.player = fullScreenPlayer
                    self.customPlayerView = fullScreenCustomPlayerView
                    self.currentCell.bgView.addSubview(fullScreenPlayer)
                    fullScreenPlayer.delegate = self
                    fullScreenCustomPlayerView.delegate = self
                    fullScreenCustomPlayerView.chooseDefitionView.isHidden = true
                    fullScreenCustomPlayerView.titleLabel.font = UIFont.systemFont(ofSize: 15)
                    fullScreenPlayer.snp.makeConstraints({ (make) in
                        make.edges.equalTo(self.currentCell.videoPreImage)
                    })

                }
                
                self.navigationController?.present(vpVideoDetailVC, animated: true, completion: nil)
                
            default:
                
                
                VPLog("[Error] unhandled Action")
            }
        }
      
    
    }
}

// MARK: - ---------------------------------- BMPlayerDelegate ----------------------------------
extension VPNewsVideoViewController:BMPlayerDelegate{
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
        VPLog(state)
//        switch state {
//        case .playedToTheEnd:
//            if self.player.isPlaying{
//                self.removePlayer()
//                VPLog("end")
//            }
//        default:
//            print("")
//        }
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
//            print("loadedTimeDidChange",totalDuration)
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
//        print("playTimeDidChange",currentTime)
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
//        VPLog(playing)
//        player.play()
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
//        VPLog(isFullscreen)
    }
    
}

