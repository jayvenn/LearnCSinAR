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
        let buttonText = NSLocalizedString("Begin", comment: "Begin")
        let button = ActionButton(type: .system)
        button.setTitle(buttonText, for: .normal)
        button.addTarget(self, action: #selector(beginButtonDidTouchUpInside(_:)), for: .touchUpInside)
        button.accessibilityLabel = buttonText
        button.accessibilityHint = "Course selection"
        return button
    }()
    
    private let contributeButton: AlternateActionButton = {
        let button = AlternateActionButton(type: .system)
        let string = "Contribute"
        let text = NSLocalizedString(string, comment: string)
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(contributeButtonDidTouchUpInside), for: .touchUpInside)
        button.accessibilityLabel = string
        button.accessibilityHint = "Send email"
        return button
    }()
    
    fileprivate lazy var bottomStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [beginButton, UIView()])
        let stackView = UIStackView(arrangedSubviews: [beginButton, contributeButton])
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
    var contributeButtonHeightConstraint: Constraint?
    
    @objc private func beginButtonDidTouchUpInside(_ sender: UIButton) {
        let navigationController = MenuNavigationController()
        present(navigationController, animated: true)
    }
    
    @objc private func contributeButtonDidTouchUpInside(_ sender: UIButton) {
        sendContributionMessage()
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
        
        contributeButton.snp.makeConstraints {
            $0.height.equalTo(beginButton)
        }
    }
    
    func setHeaderLabelFont() {
        let titleText = "Learn CS in AR"
//        let subTitleText = NSLocalizedString("Made for CS Students", comment: "Made for CS Students")
        let subTitleText = NSLocalizedString("Computer Science for Everyone", comment: "Computer Science for Everyone")
        
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
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                   NSAttributedString.Key.font: titleTextFont]
        
        
        let titleAttributedText = NSMutableAttributedString(string: "\(titleText)\n", attributes: titleTextAttributes)
        let subTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                      NSAttributedString.Key.font: subtitleTextFont]
        let subTitleAttributedText = NSMutableAttributedString(string: "\(subTitleText)",
            attributes: subTitleTextAttributes)
        titleAttributedText.append(subTitleAttributedText)
        headerLabel.accessibilityValue = "\(titleText). \(subTitleText)."
        headerLabel.attributedText = titleAttributedText
        headerLabel.setNeedsDisplay()
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
        contributeButton.titleLabel?.font = font
    }
    
    fileprivate func setUpUI() {
        view.backgroundColor = .white
    }
}
