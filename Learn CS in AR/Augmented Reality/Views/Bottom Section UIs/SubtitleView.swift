//
//  SubtitleView.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/16/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

final class SubtitleView: BaseARView {
    
    lazy var textView = SubtitleTextView(lesson: lesson)
    
    lazy var speakerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "speaker").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(speakerButtonDidTouchUpInside(_:)), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    override init(lesson: Lesson) {
        super.init(lesson: lesson)
        textView.alwaysBounceVertical = true
    }
    
    // MARK: SubtitleView - Action methods
    @objc func speakerButtonDidTouchUpInside(_ sender: UIButton) {
        delegate?.speakerButtonDidTouchUpInside()
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        stackView.addArrangedSubview(textView)
        
        mainView.addSubview(speakerButton)
        speakerButton.snp.makeConstraints {
            $0.size.equalTo(58)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-32)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: SubtitleView - Layout
extension SubtitleView {
    
    func fadeInSpeakerButton() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animationDuration) {
                self.speakerButton.alpha = 1
            }
        }
    }
    
    func fadeOutSpeakerButton() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animationDuration) {
                self.speakerButton.alpha = 0
            }
        }
    }
}

// MARK: SubtitleView - Ordering
extension SubtitleView {
    func setOrdering() {
        setOrderingTitleLabel()
        textView.setOrderingText()
    }
    
    func setOrderingTitleLabel() {
        let titleColor = UIColor.black
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: getTitleLabelFont()]
        let titleAttributedText = NSMutableAttributedString(string: LocalizedString.ordering, attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
        titleLabel.accessibilityLabel = LocalizedString.ordering
    }
    
    func setOperation() {
        setOperationTitleLabel()
        textView.setOperationText()
    }
    
    func setOperationTitleLabel() {
        let titleColor = UIColor.black
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: getTitleLabelFont()]
        let titleAttributedText = NSMutableAttributedString(string: LocalizedString.operation, attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.accessibilityLabel = LocalizedString.operation
    }
}


// MARK: SubtitleView - Big O
extension SubtitleView {
    func setBigO() {
        setBigOTitleLabel()
        textView.setBigOText()
        titleLabel.accessibilityLabel = "Big O"
    }
    
    func setBigOTitleLabel() {
        let titleColor = UIColor.black
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: getTitleLabelFont()]
        let titleAttributedText = NSMutableAttributedString(string: "Big O", attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
    }
}


