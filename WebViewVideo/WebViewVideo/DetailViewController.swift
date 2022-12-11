//
//  DetailViewController.swift
//  WebViewVideo
//
//  Created by Ikhwan on 11/12/22.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    var videoPlayer: AVPlayer?
    
    let videoSection: UIView = {
        let vs = UIView()
        return vs
    }()
    
    let videoCover: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(
            systemName: "play.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 30,
                weight: .regular
            )
        )
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        return activity
    }()
    
    let videoTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let videoWebButton: UIButton = {
        let button = UIButton()
        
        
        let buttonAttr: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 14),
              .foregroundColor: UIColor.systemBlue,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        
        let attributedText = NSMutableAttributedString(
                string: "Open Website",
                attributes: buttonAttr
             )
        
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    let video: VideoModel
    
    init(video: VideoModel) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoSection()
        setupVideoTitleAndButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupVideoSectionLayout()
        setupVideoTitleAndButtonLayout()
    }
    
    func setupVideoSection() {
        view.addSubview(videoSection)
        videoSection.addSubview(videoCover)
        videoSection.addSubview(playButton)
        videoSection.addSubview(activityIndicator)
        videoCover.image = UIImage(named: video.thumbnail)
        
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    func setupVideoSectionLayout() {
        videoSection.frame = CGRect(
            x: 0,
            y: navigationController?.navigationBar.bottom ?? 50,
            width: view.width,
            height: view.height / 3
        )
        
        videoCover.frame = CGRect(
            x: 0,
            y: 0,
            width: videoSection.width,
            height: videoSection.height
        )
        
        let buttonSize: CGFloat = 50
        
        playButton.frame = CGRect(
            x: (videoSection.width / 2) - (buttonSize / 2),
            y: (videoSection.height / 2) - (buttonSize / 2),
            width: buttonSize,
            height: buttonSize
        )
        
        activityIndicator.center = CGPoint(
            x: videoSection.width / 2,
            y: videoSection.height / 2
        )
    }
    
    func setupVideoTitleAndButton() {
        videoTitle.text = video.title
        videoWebButton.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        view.addSubview(videoTitle)
        view.addSubview(videoWebButton)
    }
    
    func setupVideoTitleAndButtonLayout() {
        videoTitle.frame = CGRect(
            x: 10,
            y: videoSection.bottom + 10,
            width: view.width - 20,
            height: 60
        )
        
        videoWebButton.frame = CGRect(
            x: (view.width / 2) - 50,
            y: videoTitle.bottom + 20,
            width: 100,
            height: 30
        )
    }
    
    @objc func playButtonTapped() {
        playButton.isHidden = true
        activityIndicator.startAnimating()
        
        videoPlayer = AVPlayer(url: video.videoURL)
        
        
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = videoSection.bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        videoSection.layer.addSublayer(playerLayer)
        
        videoPlayer!.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        
        videoPlayer!.play()
    }
    
    @objc func openWebView() {
        let webVC = WebViewController(url: "https://github.com/instyo/learn_uikit")
        self.present(webVC, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        videoPlayer?.pause()
    }
    
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            if #available(iOS 10.0, *) {
                let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
                let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
                if newStatus != oldStatus {
                    DispatchQueue.main.async {[weak self] in
                        if newStatus == .playing || newStatus == .paused {
                            self?.activityIndicator.stopAnimating()
                        } else {
                            self?.activityIndicator.startAnimating()
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
