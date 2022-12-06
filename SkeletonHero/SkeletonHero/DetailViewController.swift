//
//  DetailViewController.swift
//  SkeletonHero
//
//  Created by Ikhwan on 06/12/22.
//

import UIKit
import Hero

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var data: LandscapeModel
    
    init(data: LandscapeModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -View Properties
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    let contentView: UIView = {
        let cv = UIView()
        return cv
    }()
    
    let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.hero.isEnabled = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.sizeToFit()
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .secondaryLabel
        label.sizeToFit()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(coverImageView)
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.text = data.description
        titleLabel.text = data.title
        
        self.view.hero.isEnabled = true
        coverImageView.hero.id = data.id.uuidString
        coverImageView.hero.modifiers = [.translate(y: 100)]
        coverImageView.image = UIImage(named: data.image)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Setup ScrollView
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 20,
            width: view.width,
            height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-20
        )
        
        scrollView.delegate = self
        scrollView.contentSize = view.bounds.size
        
        contentView.frame = scrollView.bounds
        coverImageView.frame = CGRect(
            x: 20,
            y: contentView.top,
            width: view.width - 40,
            height: 200
        )
        
        titleLabel.frame = CGRect(
            x: 20, y: coverImageView.bottom + 20,
            width: view.width - 40,
            height: 25
        )
        
        // Setup Description Label
        // Determine description label height by text
        let descHeight = descriptionLabel.systemLayoutSizeFitting(
            CGSize(
                width: view.width - 40,
                height: UIView.layoutFittingCompressedSize.height
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height

        descriptionLabel.frame = CGRect(
            x: 20,
            y: titleLabel.bottom + 10,
            width: view.width - 40,
            height: descHeight
        )
        
    }
}
