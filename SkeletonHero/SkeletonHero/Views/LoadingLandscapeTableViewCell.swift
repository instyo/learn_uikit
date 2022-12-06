//
//  LandscapeTableViewCell.swift
//  SkeletonHero
//
//  Created by Ikhwan on 05/12/22.
//

import UIKit
import SkeletonView
import Hero

class LoadingLandscapeTableViewCell: UITableViewCell {
    static let identifier = "LoadingLandscapeTableViewCell"
    
    // MARK: -View Properties
    
    let landscapeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.isSkeletonable = true
        return label
    }()
    
    let landscapePlace: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.isSkeletonable = true
        return label
    }()
    
    let landscapeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.isSkeletonable = true
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        contentView.addSubview(landscapeTitle)
        contentView.addSubview(landscapePlace)
        contentView.addSubview(landscapeImage)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize : CGFloat = contentView.height - 30
        
        landscapeImage.frame = CGRect(
            x: 10,
            y: 15,
            width: imageSize,
            height: imageSize
        )
        
        landscapeTitle.frame = CGRect(
            x: landscapeImage.right + 10,
            y: 15,
            width: contentView.width - landscapeImage.width - 30,
            height: contentView.height / 4
        )
        
        landscapePlace.frame = CGRect(
            x: landscapeImage.right + 10,
            y: landscapeTitle.bottom + 5,
            width: contentView.width / 4,
            height: contentView.height / 3
        )
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        landscapeTitle.text = nil
        landscapePlace.text = nil
        landscapeImage.image = nil
        landscapeImage.isSkeletonable = false
        landscapePlace.isSkeletonable = false
        landscapeTitle.isSkeletonable = false
    }
}
