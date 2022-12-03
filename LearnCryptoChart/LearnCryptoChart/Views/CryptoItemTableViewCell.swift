//
//  CryptoItemTableViewCell.swift
//  LearnCryptoChart
//
//  Created by Ikhwan on 20/11/22.
//

import UIKit

class CryptoItemTableViewCell: UITableViewCell {
    
    static let identifier = "CryptoItemTableViewCell"

    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemBlue
        return label
    }()
    
    let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceChangeLabel)
        contentView.addSubview(coverImage)
        contentView.addSubview(priceLabel)
        
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = contentView.height - 30
        
        coverImage.frame = CGRect(
            x: 10,
            y: 15,
            width: imageSize,
            height: imageSize
        )
        
        titleLabel.frame = CGRect(
            x: coverImage.right + 10,
            y: 15,
            width: contentView.width - coverImage.width - 30,
            height: contentView.height / 4
        )
        
        priceChangeLabel.frame = CGRect(
            x: coverImage.right + 10,
            y: titleLabel.bottom + 5,
            width: contentView.width / 4,
            height: contentView.height / 3
        )
        
        priceLabel.frame = CGRect(
            x: contentView.right - (contentView.width / 3),
            y: titleLabel.bottom + 5,
            width: contentView.width / 3,
            height: contentView.height / 3
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        priceChangeLabel.text = nil
    }
    
    func configure(with model: CryptoModel) {
        titleLabel.text = model.name
        priceLabel.text = model.price.formatted(.currency(code: "USD").locale(Locale(identifier: "en-US")))
        setupPriceChangeLabel(with: model)
        coverImage.image = UIImage(named: model.symbol.lowercased())
    }
    
    func setupPriceChangeLabel(with model: CryptoModel) {
        let isNegative = model.percentChange24H < 0
        
        priceChangeLabel.text = "\(isNegative ? "" : "+")\(String(format: "%.2f", model.percentChange24H))%"
        priceChangeLabel.textColor = isNegative ? .systemRed : .systemGreen
    }

}
