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
final class HomeViewController: BaseMenuViewController {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = -1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontForContentSizeCategory = true
        label.sizeToFit()
        label.accessibilityLabel = "App name"
        return label
    }()
    
    private let beginButton: ActionButton = {
        let buttonText = "Begin"
        let button = ActionButton(type: .system)
        button.setTitle(buttonText, for: .normal)
        button.addTarget(self, action: #selector(beginButtonDidTouchUpInside(_:)), for: .touchUpInside)
        button.accessibilityLabel = buttonText
        button.accessibilityHint = "Course selection"
        return button
    }()
    
    private let aboutButton: AlternateActionButton = {
        let button = AlternateActionButton(type: .system)
        button.setTitle("Purpose", for: .normal)
        button.addTarget(self, action: #selector(HomeViewController.aboutButtonDidTouchUpInside), for: .touchUpInside)
        button.accessibilityLabel = "Purpose"
        button.accessibilityHint = "App Purpose"
        return button
    }()
    
    fileprivate lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [beginButton, aboutButton])
//        let stackView = UIStackView(arrangedSubviews: [beginButton])
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
    
    var beginButtonHeightConstraint: Constraint?
    var aboutButtonHeightConstraint: Constraint?
    
    @objc private func beginButtonDidTouchUpInside(_ sender: UIButton) {
        let navigationController = MenuNavigationController()
//        let viewController = LessonsViewController(course: Course(courseSubject: .dataStructures))
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.navigationBar.barTintColor = .white
        present(navigationController, animated: true)
    }
    
    @objc private func aboutButtonDidTouchUpInside(_ sender: UIButton) {
        
    }
    
    
    override func configureView() {
        super.configureView()
        setHeaderLabelFont()
        setButtonFonts()
    }
}


// MARK: LoginViewController - Life cycles
extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        setUpUI()
        setHeaderLabelFont()
    }
    
}

// MARK: HomeViewController - UI, Layout, Overhead
extension HomeViewController {
    
    private func setUpLayout() {
        view.addSubviews(views: [
            stackView
            ])
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        beginButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        aboutButton.snp.makeConstraints {
            $0.height.equalTo(beginButton)
        }
    }
    
    func setHeaderLabelFont() {
        let titleText = "Learn CS in AR"
        let subTitleText = "Made for CS Students"
        
//        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
//                                   NSAttributedStringKey.font: Font(object: .titleLabel).instance]
//
        let preferredContentSizeCategory = traitCollection.preferredContentSizeCategory
        let titleTextFont: UIFont
        let subtitleTextFont: UIFont
        let heightConstraint = 44
        if preferredContentSizeCategory > .accessibilityMedium {
            titleTextFont = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(displayScale: 36))
            subtitleTextFont = UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: UITraitCollection(displayScale: 18))
            beginButton.snp.remakeConstraints {
                $0.height.equalTo(heightConstraint * 2)
            }
    
        } else {
            titleTextFont = Font(object: .titleLabel).instance
            subtitleTextFont = Font(object: .subTitleLabel).instance
            beginButton.snp.remakeConstraints {
                $0.height.equalTo(heightConstraint)
            }
        }
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                   NSAttributedStringKey.font: titleTextFont]
        
        
        let titleAttributedText = NSMutableAttributedString(string: "\(titleText)\n", attributes: titleTextAttributes)
        let subTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                      NSAttributedStringKey.font: subtitleTextFont]
        let subTitleAttributedText = NSMutableAttributedString(string: "\(subTitleText)",
            attributes: subTitleTextAttributes)
        titleAttributedText.append(subTitleAttributedText)
        headerLabel.accessibilityValue = "\(titleText). \(subTitleText)."
        headerLabel.attributedText = titleAttributedText
        headerLabel.setNeedsDisplay()
//        view.setNeedsLayout()
    }
    
    func setButtonFonts() {
        let font: UIFont
        let preferredContentSizeCategory = traitCollection.preferredContentSizeCategory
        if preferredContentSizeCategory > .accessibilityMedium {
            font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(displayScale: 18))
        } else {
            font = Font(object: .button).instance
        }
        beginButton.titleLabel?.font = font
        aboutButton.titleLabel?.font = font
    }
    
    fileprivate func setUpUI() {
        view.backgroundColor = .white
    }
}
