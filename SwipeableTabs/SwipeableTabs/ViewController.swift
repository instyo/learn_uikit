//
//  ViewController.swift
//  SwipeableTabs
//
//  Created by Ikhwan on 24/12/22.
//

import UIKit
import Tabman
import Pageboy

class ViewController: TabmanViewController {
    private var viewControllers = [FirstTabViewController(), SecondTabViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.contentInset = .zero
        
        bar.backgroundView.style = .clear
        bar.buttons.customize { (button) in
            button.tintColor = .secondaryLabel
            button.backgroundColor = .systemBackground
            button.selectedTintColor = .red
        }

        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .red
        bar.indicator.transitionStyle = .snap
        
        // Add to view
        addBar(bar, dataSource: self, at: .navigationItem(item: self.navigationItem))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

extension ViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let titles = ["Podcast", "Radio"]
        bar.backgroundColor = .systemBackground
        bar.tintColor = .red
        let item = TMBarItem(title: titles[index])
        return item
    }
}
