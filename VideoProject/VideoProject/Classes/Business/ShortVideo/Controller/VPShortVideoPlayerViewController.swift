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

    var smallVideo = VPNewsVideoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func initSubviews() {
        super.initSubviews()
        customPlayerView = VPShortVideoCustomPlayerView()
        player = BMPlayer(customControlView: customPlayerView)
        
        if  let videoURLStr = smallVideo.raw_data.video.play_addr.url_list.first             {
            let dataTask = URLSession.shared.dataTask(with: URL.init(string: videoURLStr)!, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if self.player.isPlaying { self.player.pause() }
                   
                    self.bgView.addSubview(self.player)
                    self.player.snp.makeConstraints({ $0.edges.equalTo(self.bgView) })
                    let asset = BMPlayerResource(url: URL(string: response!.url!.absoluteString)!)
                    self.player.setVideo(resource: asset)
                }
            })
            dataTask.resume()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
