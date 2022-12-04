//
//  PlaceViewController.swift
//  NearbyLocation
//
//  Created by Ikhwan on 04/12/22.
//

import UIKit
import MapKit

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: -View Properties
    let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    // MARK: -Properties
    
    private let location: String
    
    private let items : [MKMapItem]
    
    init(location: String, items: [MKMapItem]) {
        self.location = location
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        
        labelTitle.text = location
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        labelTitle.frame = CGRect(x: 20, y: 0, width: view.width - 40, height: 60)
        tableView.frame = CGRect(x: 0, y: labelTitle.bottom, width: view.width, height: view.height)
    }
    
    
    // MARK: -Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = place.placemark.name ?? "-"
        content.secondaryText = "\(place.placemark.locality ?? ""), \(place.placemark.country ?? "")"
        content.image = UIImage(systemName: "mappin.square.fill")
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
