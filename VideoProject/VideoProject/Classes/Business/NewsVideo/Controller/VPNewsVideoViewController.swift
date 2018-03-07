//
//  VPNewsVideoViewController.swift
//  VideoProject
//
//  Created by avazuholding on 2018/3/2.
//  Copyright © 2018年 icoin. All rights reserved.
//

import UIKit
import BMPlayer
class VPNewsVideoViewController: VPBaseTableViewController,UITableViewDelegate,UITableViewDataSource {
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
            var num = arc4random()%10
            num = 15
            self.dataArr.removeAllObjects()
            for _  in 0...num+1 {
                self.dataArr.add("new")
            }
            VPNetworkManager.loadNewsVideo { (pull, videoModelArr) in
//                print(videoModelArr)
                self.newsVideoModelArr = videoModelArr
                
                for newsVideoModel in  self.newsVideoModelArr {
                    print(newsVideoModel)
                    
                }
            }
            
        }
        
       
    }
    
    
    
    
    //UITableviewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArr.count
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
        cell.textLabel?.text = (self.dataArr[indexPath.row] as! String)
        
        if indexPath.row == 0 {
            cell.contentView.addSubview(self.player)
            self.player.setVideo(resource: BMPlayerResource.init(url: URL.init(string: "http://v3-tt.ixigua.com/9325834736e521a2efabdc45c866dd36/5a9f90c1/video/m/220ac6a882370064859a56e930649beddb3115507710000c2ddaa8468dc/")!))
            self.player.snp.makeConstraints {
                $0.edges.equalTo(cell.contentView)
                
            }
            self.player.play()
        }
        
        
        return cell
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension VPShotVideoViewController{
    
}



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

