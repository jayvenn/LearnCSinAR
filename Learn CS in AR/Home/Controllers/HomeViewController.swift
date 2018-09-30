//
//  HomeViewController.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit
import MessageUI

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
    var aboutButtonHeightConstraint: Constraint?
    
    @objc private func beginButtonDidTouchUpInside(_ sender: UIButton) {
        let navigationController = MenuNavigationController()
        present(navigationController, animated: true)
    }
    
    @objc private func contributeButtonDidTouchUpInside(_ sender: UIButton) {
        sendContributionMessage()
    }
    
    func sendContributionMessage() {
        let bodyText = generateBodyText()
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["LearnCSinAR@gmail.com"])
            mail.setMessageBody("<p>\(bodyText)</p>", isHTML: true)
            present(mail, animated: true)
        } else if MFMessageComposeViewController.canSendText() {
            let viewController = MFMessageComposeViewController()
            viewController.recipients = ["+6587766238"]
            viewController.messageComposeDelegate = self
            viewController.body = bodyText
            present(viewController, animated: true)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    func generateBodyText() -> String {
        let bodyText = """
        Hi Learn CS in AR,

        I'm here to contribute for the greater purpose than myself.

        I believe education is a basic human right.

        I believe in pushing education forward for humanity.

        I believe in putting others in front of me.

        I want to contribute because [your why].

        I can contribute by [doing] by [date].

        This contribution can help [who/what] achieve [what].

        My one highly scarce and in-demand skill is [what].

        My one highly scarce but not in-demand skill is [what].

        I will only send this message only if I believe in this message.
        
        My name is ...
        """
        return bodyText
    }
    
    func showSendMailErrorAlert() {
        let title = "Could Not Open Mail or Messages"
        let message = "Set configurations and try again."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    override func configureView() {
        super.configureView()
        setHeaderLabelFont()
        setButtonFonts()
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension HomeViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

// MARK: - MFMessageComposeViewControllerDelegate
extension HomeViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
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
        let subTitleText = NSLocalizedString("Made for CS Students", comment: "Made for CS Students")
        
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
