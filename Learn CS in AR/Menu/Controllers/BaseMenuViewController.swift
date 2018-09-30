//
//  BaseMenuViewController.swift
//  Learn CS in AR
//
//  Created by Macbook on 8/13/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

class BaseMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        configureView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: .main) { [weak self] (notification) in
            guard let `self` = self else { return }
            self.didChangePreferredContentSize()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didChangePreferredContentSize() {
        configureView()
    }
    
    func configureView() {
        let titleFont = UIFont.preferredFont(forTextStyle: .headline)
        FontManager.shared.titleFont = titleFont
        let subtitleFont = UIFont.preferredFont(forTextStyle: .subheadline)
        FontManager.shared.subtitleFont = subtitleFont
    }
    
}
