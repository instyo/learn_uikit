//
//  FirstTabViewController.swift
//  SwipeableTabs
//
//  Created by Ikhwan on 24/12/22.
//

import UIKit

class FirstTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        var content = cell.defaultContentConfiguration()
        content.text = "Podcast Title : \(indexPath.row)"
        content.secondaryText = "Lorem ipsum dolor sit amet"
        content.image = UIImage(systemName: "music.note")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        cell.contentConfiguration = content
        return cell
    }
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(
            x: view.safeAreaInsets.left,
            y: navigationController?.navigationBar.top ?? 0,
            width: view.width - view.safeAreaInsets.left,
            height: view.height - (navigationController?.navigationBar.top ?? 0)
        )
    }
}
