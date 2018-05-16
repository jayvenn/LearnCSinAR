//
//  HomeViewController.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

// MARK: HomeViewController
class HomeViewController: UIViewController {
    
    private let headerLabel: UILabel = {
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                   NSAttributedStringKey.font: Font(object: .titleLabel).instance]
        
        let titleAttributedText = NSMutableAttributedString(string: "Learn CS in AR\n", attributes: titleTextAttributes)
        let spacingTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)]
        let spacingAttributedText = NSMutableAttributedString(string: "\n", attributes: titleTextAttributes)
        let subTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                      NSAttributedStringKey.font: Font(object: .subTitleLabel).instance]
        let subTitleAttributedText = NSMutableAttributedString(string: "Made for CS Students",
                                                               attributes: subTitleTextAttributes)
        titleAttributedText.append(subTitleAttributedText)
        let label = UILabel()
        label.numberOfLines = -1
        label.attributedText = titleAttributedText
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.sizeToFit()
        return label
    }()
    
    private let beginButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("Begin", for: .normal)
        button.addTarget(self, action: #selector(HomeViewController.beginButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    private let aboutButton: AlternateActionButton = {
        let button = AlternateActionButton()
        button.setTitle("Purpose", for: .normal)
        button.addTarget(self, action: #selector(HomeViewController.aboutButtonDidTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [beginButton, aboutButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, bottomStackView])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    @objc private func beginButtonDidTouchUpInside(_ sender: UIButton) {
        let viewController = MenuNavigationController()
        present(viewController, animated: true)
    }
    
    @objc private func aboutButtonDidTouchUpInside(_ sender: UIButton) {
        
    }

}


// MARK: LoginViewController - Life cycles
extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpUI()
    }
    
}

// MARK: HomeViewController - UI, Layout, Overhead
extension HomeViewController {
    
    private func setUpLayout() {
        view.addSubviews(views: [
            stackView
            ])
        
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        beginButton.snp.makeConstraints { (make) in
            make.height.equalTo(44)
        }
        
        aboutButton.snp.makeConstraints { (make) in
            make.height.equalTo(beginButton)
        }
    }
    
    fileprivate func setUpUI() {
        view.backgroundColor = .white
    }
}
