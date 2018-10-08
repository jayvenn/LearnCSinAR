//
//  BaseMenuViewController.swift
//  Learn CS in AR
//
//  Created by Macbook on 8/13/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import MessageUI

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
    
    func sendContributionMessage() {
        func showSendMailErrorAlert() {
            let title = "Send an email to:"
            let message = "LearnCSinAR@gmail.com"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "DONE", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        
        let bodyText = generateBodyText()
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["LearnCSinAR@gmail.com"])
            mail.setSubject("Learn CS in AR - App Contribution")
            mail.setMessageBody(bodyText, isHTML: false)
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
        Hi Learn CS in AR App Team,

        I'm here to contribute for the greater purpose than myself.

        I believe that education is a basic human right.

        I believe in pushing education forward for humanity.

        I believe in putting others in front of me.

        I want to contribute because [your why].

        I can contribute by [doing what] by [date].

        This contribution can help [who/what] achieve [what].

        My one highly scarce and in-demand skill is [what].

        My one highly scarce but not in-demand skill is [what].

        I will only send this message only if I believe in this message.
        
        My name is ...

        ---
        
        If you know someone who is a fit of the description above, feel free to also forward this message to him/her.
        """
        return bodyText
    }
}

// MARK: - BaseMenuViewController
extension BaseMenuViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

// MARK: - BaseMenuViewController
extension BaseMenuViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
}
