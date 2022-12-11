//
//  ViewController.swift
//  WebViewVideo
//
//  Created by Ikhwan on 11/12/22.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    let tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.estimatedRowHeight = 250
        tv.register(
            VideoTableViewCell.self,
            forCellReuseIdentifier: VideoTableViewCell.identifier
        )
        return tv
    }()
    
    var playerViewController = AVPlayerViewController()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        return activity
    }()
    
    let playButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle("Play In View", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let playButton2 : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Play In View Controller", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let videoView : UIView = {
        let vv = UIView()
        vv.backgroundColor = .systemCyan
        return vv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        view.addSubview(activityIndicator)
//        view.addSubview(playButton)
//        view.addSubview(playButton2)
//        view.addSubview(videoView)
//
//        playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
//        playButton2.addTarget(self, action: #selector(openVideo), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        title = "Video Library"
        
//        activityIndicator.frame = CGRect(x: view.center.x, y: 20, width: 100, height: 100)
//        activityIndicator.style = .large
//        activityIndicator.hidesWhenStopped = true
//
//        playButton.frame = CGRect(
//            x: 20,
//            y: 200,
//            width: 100,
//            height: 30
//        )
//
//        playButton2.frame = CGRect(
//            x: playButton.right + 20,
//            y: 200,
//            width: 200,
//            height: 30
//        )
//
//        videoView.frame = CGRect(
//            x: 20,
//            y: playButton.bottom + 20,
//            width:view.width - 40,
//            height: 200
//        )
    }
    
    @objc func playVideo() {
        let player = AVPlayer(url: URL(string: "https://raw.githubusercontent.com/instyo/scheme_tester/main/file_example_MP4_480_1_5MG.mp4")!)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = .resizeAspect
        
        videoView.layer.addSublayer(playerLayer)
        
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        
        player.play()
    }
    
    @objc func openVideo() {
        let player = AVPlayer(url: URL(string: "https://file-examples.com/storage/fee589dbcc6394c129ba7e9/2017/04/file_example_MP4_480_1_5MG.mp4")!)
        playerViewController.player = player
        self.present(playerViewController, animated: true)
    }

    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
                if #available(iOS 10.0, *) {
                    let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
                    let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
                    if newStatus != oldStatus {
                       DispatchQueue.main.async {[weak self] in
                           if newStatus == .playing || newStatus == .paused {
                            self!.activityIndicator.stopAnimating()
                           } else {
                            self!.activityIndicator.startAnimating()
                           }
                       }
                    }
                } else {
                    // Fallback on earlier versions
                    self.activityIndicator.stopAnimating()
                }
            }
        }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VideoModelProvider.all().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: VideoTableViewCell.identifier,
            for: indexPath
        ) as? VideoTableViewCell else {
            return UITableViewCell()
        }
        
        let video = VideoModelProvider.all()[indexPath.row]
        cell.configure(with: video)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = VideoModelProvider.all()[indexPath.row]
        let vc = DetailViewController(video: video)
        navigationController?.pushViewController(vc, animated: true)
    }
}
