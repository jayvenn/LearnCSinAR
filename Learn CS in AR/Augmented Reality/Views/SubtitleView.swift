//
//  SubtitleView.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/16/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

protocol SubtitleViewDelegate: class {
    func closeButtonDidTouchUpInside()
}

class SubtitleView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    var lesson: Lesson
    
    weak var delegate: SubtitleViewDelegate?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "arrow down"), for: .normal)
        button.addTarget(self, action: #selector(SubtitleView.closeButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textView = SubtitleTextView(lesson: lesson)
    
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, closeButton])
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, textView])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(frame: .zero)
        setUpLayout()
        setInitialProperties()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        roundCorners([.topLeft, .topRight], radius: 30.0)
    }
    
    func setInitialProperties() {
        alpha = 0
        backgroundColor = UIColor.white.withAlphaComponent(1)
    }
    
    // MARK: SubtitleView - Action methods
    @objc func closeButtonDidTouchUpInside(_ sender: UIButton) {
        delegate?.closeButtonDidTouchUpInside()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: SubtitleView - Layout
extension SubtitleView {
    func setUpLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(snp.leading).offset(24)
            make.top.equalTo(snp.top).offset(32)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.width.equalTo(44)
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
                                   NSAttributedStringKey.font: Font(object: .textViewTitle).instance]
        let titleAttributedText = NSMutableAttributedString(string: "\(lesson.name.rawValue) Ordering", attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
    }
}

// MARK: SubtitleView - Operation
extension SubtitleView {
    func setOperation() {
        setOperationTitleLabel()
        textView.setOperationText()
    }
    
    func setOperationTitleLabel() {
        let titleColor = UIColor.black
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: Font(object: .textViewTitle).instance]
        let titleAttributedText = NSMutableAttributedString(string: "\(lesson.name.rawValue) Operation\n", attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
        titleLabel.lineBreakMode = .byTruncatingTail
    }
}

// MARK: SubtitleView - Big O
extension SubtitleView {
    func setBigO() {
        setBigOTitleLabel()
        textView.setBigOText()
    }
    
    func setBigOTitleLabel() {
        let titleColor = UIColor.black
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: Font(object: .textViewTitle).instance]
        let titleAttributedText = NSMutableAttributedString(string: "\(lesson.name.rawValue) Big O\n", attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
    }
}
