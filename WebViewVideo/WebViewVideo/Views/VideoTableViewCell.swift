//
//  VideoTableViewCell.swift
//  WebViewVideo
//
//  Created by Ikhwan on 11/12/22.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    static let identifier = "VideoTableViewCell"
    
    let coverImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let videoTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(coverImage)
        contentView.addSubview(videoTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coverImage.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.width - 20,
            height: 180
        )

        videoTitle.frame = CGRect(
            x: 10,
            y: coverImage.bottom + 10,
            width: contentView.width - 20,
            height: 40
        )
        
//        coverImage.frame.size = CGSize(width: contentView.width, height: 200)
//
//        NSLayoutConstraint.activate([
//            coverImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            coverImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//            coverImage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
//            coverImage.bottomAnchor.constraint(equalTo: videoTitle.topAnchor),
//
//            videoTitle.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 10),
//            videoTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//            videoTitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
//            videoTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image = nil
        videoTitle.text = nil
    }
    
    func configure(with video: VideoModel) {
        coverImage.image = UIImage(named: video.thumbnail)
        videoTitle.text = video.title
    }

}
