//
//  SecondTabViewController.swift
//  SwipeableTabs
//
//  Created by Ikhwan on 24/12/22.
//

import UIKit

class SecondTabViewController: UIViewController {

    let imageLabel : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "radio")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        iv.sizeToFit()
        iv.contentMode = .scaleToFill
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        view.addSubview(imageLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageLabel.frame = CGRect(
            x: view.center.x - 50,
            y: view.center.y,
            width: 100,
            height: 100
        )
    }
}
