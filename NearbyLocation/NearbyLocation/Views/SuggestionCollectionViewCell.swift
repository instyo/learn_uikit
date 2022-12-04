//
//  SuggestionCollectionViewCell.swift
//  NearbyLocation
//
//  Created by Ikhwan on 04/12/22.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SuggestionCollectionViewCell"
    
    let itemView = {
        let itemView = UIView()
        
        itemView.clipsToBounds = true
        itemView.backgroundColor = .systemBackground
        itemView.layer.cornerRadius = 20
        
        return itemView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(itemView)
        itemView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height)
        titleLabel.frame = CGRect(x: 0, y: 0, width: itemView.width, height: itemView.height)
    }
    
    
    func configure(title: String, isSelected: Bool) {
        titleLabel.text = title
        if isSelected {
            itemView.backgroundColor = .systemBlue
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        itemView.backgroundColor = .systemBackground
    }
}
