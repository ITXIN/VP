//
//  VPNewsVideoViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import BMPlayer
class VPNewsVideoViewController: VPBaseTableViewController {
    let newsVideoCellIdentifier = "newsVideoCellIdentifier"
    
  var newsVideoModelArr = [VPNewsVideoModel]()
    /// 播放器
    lazy var player: BMPlayer = BMPlayer(customControlView: VPNewsCustomPlayerView())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.backgroundColor = UIColor.yellow

        // Do any additional setup after loading the view.
    }
    override func initSubviews() {
        super.initSubviews()
        self.player.delegate = self
        
        for i in 0...10 {
            self.dataArr.add(String(i))
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
         self.tableViewRegisterClass(cellClass: UITableViewCell.self, identifier: newsVideoCellIdentifier)
        self.headerRefreshingBlock = {
            self.dataArr.removeAllObjects()
            VPNetworkManager.loadNewsVideo { (pull, videoModelArr) in
//                print(videoModelArr)
                self.newsVideoModelArr = videoModelArr
//                var newsVideoModel:VPNewsVideoModel = nil
                for  newsVideoModel  in  self.newsVideoModelArr {
        print("abstract:"+newsVideoModel.abstract+"displayurl:"+newsVideoModel.display_url+"video_id:"+newsVideoModel.video_detail_info.video_id)
//                    self.dataArr.add(newsVideoModel)

                }
                self.tableView.reloadData()
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
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vpVideoDetailVC = VPNewsVideoDetailViewController()
        self.navigationController?.pushViewController(vpVideoDetailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: newsVideoCellIdentifier, for: indexPath)
        if self.newsVideoModelArr.count > 0 {
            let newsVideoModel = self.newsVideoModelArr[indexPath.row]
            cell.textLabel?.text = newsVideoModel.abstract
            if indexPath.row == 0 {
                cell.contentView.addSubview(self.player)
                VPNetworkManager.parseVideoRealURL(video_id: newsVideoModel.video_detail_info.video_id, completionHandler: { (response) in
                    let playurl = response.video_list.video_1.mainURL
                    print("response",playurl)
                    self.player.setVideo(resource: BMPlayerResource.init(url: URL.init(string: playurl)!))
                })
                
                self.player.snp.makeConstraints {
                    $0.edges.equalTo(cell.contentView)
                }
            }
        }
        
        return cell
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

