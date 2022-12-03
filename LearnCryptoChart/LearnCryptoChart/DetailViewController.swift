//
//  DetailViewController.swift
//  LearnCryptoChart
//
//  Created by Ikhwan on 03/12/22.
//

import UIKit
import SwiftChart

class DetailViewController: UIViewController {
    
    let data: CryptoModel
    
    init(data: CryptoModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let chart: Chart = {
        let chart = Chart()
        return chart
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(priceLabel)
        view.addSubview(priceChangeLabel)
        view.addSubview(chart)
        view.addSubview(descriptionLabel)
        setupChart()
        
        descriptionLabel.text = data.cryptoModelDescription
        //        navigationItem.title = data.symbol
        //        configureBarButtons()
    }
    
    private func configureBarButtons() {
        let imageView = UIImageView()
        //        imageView.frame.size = CGSize(width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: data.symbol.lowercased())
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
        navigationItem.titleView = imageView
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Actions
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPriceLabel()
        setupPriceChangeLabel()
        
        chart.frame = CGRect(x: 0, y: priceChangeLabel.bottom + 40, width: view.width, height: view.height / 4)
        
        descriptionLabel.frame = CGRect(x: 10, y: chart.bottom, width: view.width - 20, height: view.height / 4)
    }
    
    func setupPriceLabel() {
        let labelWidth = view.height / 6
        
        priceLabel.frame = CGRect(
            x: (view.width - labelWidth) / 2,
            y: navigationController?.navigationBar.frame.maxY ?? 0,
            width: labelWidth,
            height: 20
        )
        
        priceLabel.text = "$\(String(format: "%.2f", data.price))"
    }
    
    func setupPriceChangeLabel() {
        let labelWidth = view.height / 6
        
        priceChangeLabel.frame = CGRect(
            x: (view.width - labelWidth) / 2,
            y: priceLabel.bottom + 5,
            width: labelWidth,
            height: 20
        )
        
        let isNegative = data.percentChange24H < 0
        
        priceChangeLabel.text = "\(isNegative ? "" : "+")\(String(format: "%.2f", data.percentChange24H))%"
        priceChangeLabel.textColor = isNegative ? .systemRed : .systemGreen
    }
    
    // Generate Default Chart
    func setupChart() {
        let series = ChartSeries((1...50).map( {_ in Double.random(in: 1...50)} ))
        
        series.area = true
        chart.showXLabelsAndGrid = false
        chart.showYLabelsAndGrid = false
        chart.add(series)
    }
    
}

extension DetailViewController : ChartDelegate {
    func didTouchChart(_ chart: SwiftChart.Chart, indexes: [Int?], x: Double, left: CGFloat) {
        print(">> Touch")
    }
    
    func didFinishTouchingChart(_ chart: SwiftChart.Chart) {
        print(">> Finish Touch")
    }
    
    func didEndTouchingChart(_ chart: SwiftChart.Chart) {
        print(">> End Touch")
    }
}
