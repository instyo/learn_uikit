//
//  ToggleTabView.swift
//  SwipeableTabs
//
//  Created by Ikhwan on 25/12/22.
//

import UIKit

protocol ToggleTabViewDelegate: AnyObject {
    func toggleTabViewDidTapForYou(_ toggleView: ToggleTabView)
    func toggleTabViewDidTapPodcast(_ toggleView: ToggleTabView)
    func toggleTabViewDidTapRadio(_ toggleView: ToggleTabView)
    func toggleTabViewDidTapAudiobook(_ toggleView: ToggleTabView)
}

class ToggleTabView: UIView {
    
    enum State {
        case forYou
        case podcast
        case radio
        case audioBook
    }
    
    var state: State = .forYou
    
    weak var delegate: ToggleTabViewDelegate?
    
    private let forYouButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("For You", for: .normal)
        return button
    }()
    
    private let podcastButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Podcast", for: .normal)
        return button
    }()
    
    private let radioButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Radio", for: .normal)
        return button
    }()
    
    private let audioBookButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Audiobook", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(forYouButton)
        addSubview(podcastButton)
        addSubview(radioButton)
        addSubview(audioBookButton)
        addSubview(indicatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapForYou() {
        update(for: .forYou)
        delegate?.toggleTabViewDidTapForYou(self)
    }
    
    @objc func didTapPodcast() {
        update(for: .podcast)
        delegate?.toggleTabViewDidTapPodcast(self)
    }
    
    @objc func didTapRadio() {
        update(for: .radio)
        delegate?.toggleTabViewDidTapRadio(self)
    }
    
    @objc func didTapAudioBook() {
        update(for: .audioBook)
        delegate?.toggleTabViewDidTapAudiobook(self)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        forYouButton.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        podcastButton.frame = CGRect(x: forYouButton.right, y: 0, width: 80, height: 40)
        radioButton.frame = CGRect(x: podcastButton.right, y: 0, width: 80, height: 40)
        audioBookButton.frame = CGRect(x: radioButton.right, y: 0, width: 80, height: 40)
    }
    
    func layoutIndicator() {
        switch state {
        case .forYou:
            indicatorView.frame = CGRect(
                x: 0,
                y: forYouButton.bottom,
                width: 80,
                height: 3
            )
        case .podcast:
            indicatorView.frame = CGRect(
                x: podcastButton.center.x,
                y: podcastButton.bottom,
                width: 80,
                height: 3
            )
        case .radio:
            indicatorView.frame = CGRect(
                x: radioButton.center.x,
                y: radioButton.bottom,
                width: 80,
                height: 3
            )
        case .audioBook:
            indicatorView.frame = CGRect(
                x: audioBookButton.center.x,
                y: audioBookButton.bottom,
                width: 80,
                height: 3
            )
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
