//
//  ViewController.swift
//  LearnCryptoChart
//
//  Created by Ikhwan on 20/11/22.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    private var searchResults: [CryptoModel] = []
    private var cryptoList: [CryptoModel] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 300
        tableView.register(
            CryptoItemTableViewCell.self,
            forCellReuseIdentifier: CryptoItemTableViewCell.identifier
        )
        return tableView
    }()
    
    private func fetchData() {
        APICaller.shared.getCryptoList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.cryptoList.append(contentsOf: data)
                    self?.searchResults.append(contentsOf: data)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Crypto Prices"
        view.backgroundColor = .systemPink
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupSearchBar()

        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: tableView.width, height: 70)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search coin"
        searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchResults = cryptoList
            tableView.reloadData()
            return
        }
        
        searchResults = cryptoList.filter {
            $0.name.lowercased().contains(searchText.lowercased())
            || $0.symbol.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoItemTableViewCell.identifier,
            for: indexPath
        ) as? CryptoItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: searchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = searchResults[indexPath.row]
        
        let vc = DetailViewController(data: data)
        vc.title = data.symbol
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .popover
        
        let navVc = UINavigationController(rootViewController: vc)
        
        if let sheet = navVc.sheetPresentationController {
            // 3
            sheet.detents = [.medium(), .large()]
            
        }
        
        self.present(navVc, animated: true)
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

