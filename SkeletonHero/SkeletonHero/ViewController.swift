//
//  ViewController.swift
//  SkeletonHero
//
//  Created by Ikhwan on 05/12/22.
//

import UIKit
import SkeletonView
import Hero

class ViewController: UIViewController {
    // MARK: -Properties
    var landscapeItems : [LandscapeModel] = [LandscapeModel]()
    let maxData: Int = 20
    var hasReachedMax: Bool {
        return landscapeItems.count >= maxData
    }
    
    // MARK: -View Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Landscapes"
        
        view.hero.isEnabled = true
        
        view.backgroundColor = .systemBlue
        
        view.addSubview(tableView)
        
        // Setup Table
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            LandscapeTableViewCell.self,
            forCellReuseIdentifier: LandscapeTableViewCell.identifier
        )
        
        tableView.register(
            LoadingLandscapeTableViewCell.self,
            forCellReuseIdentifier: LoadingLandscapeTableViewCell.identifier
        )
        
        // Start Animation On TableView
        tableView.isSkeletonable = true
        view.showAnimatedSkeleton()
        tableView.showAnimatedSkeleton()
        
        tableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.landscapeItems = LandscapeProvider.all()
            self.tableView.stopSkeletonAnimation()
            self.tableView.hideSkeleton()
            self.tableView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func loadMoreLandscapes() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.landscapeItems.append(contentsOf: LandscapeProvider.all())
            self.tableView.reloadData()
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, SkeletonTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return hasReachedMax ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.landscapeItems.count
        }
        
        if section == 1 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let item = self.landscapeItems[indexPath.row]
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LandscapeTableViewCell.identifier,
                for: indexPath
            ) as? LandscapeTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(landscape: item)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LoadingLandscapeTableViewCell.identifier,
                for: indexPath
            ) as? LoadingLandscapeTableViewCell else {
                return UITableViewCell()
            }
            
            cell.showAnimatedSkeleton()
            return cell
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return LandscapeTableViewCell.identifier
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.landscapeItems.count - 1
        
        if indexPath.row == lastElement {
            if !hasReachedMax {
                self.loadMoreLandscapes()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.landscapeItems[indexPath.row]
        let vc = DetailViewController(data: item)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
