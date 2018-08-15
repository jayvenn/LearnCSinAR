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
    func sliderButtonDidTouchUpInside()
    func maximizeSubtitleView()
    func minimizeSubtitleView()
}

final class SubtitleView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    var lesson: Lesson
    
    weak var delegate: SubtitleViewDelegate?
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "arrow down").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(SubtitleView.closeButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textView = SubtitleTextView(lesson: lesson)
    
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
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
    
    lazy var sliderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red:0.82, green:0.82, blue:0.85, alpha:1.00)
        return button
    }()
    
    lazy var expanderView: UIView = {
        let view = UIView()
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(maximizeSubtitleView(_:)))
        swipeUpGesture.direction = .up
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(minimizeSubtitleView(_:)))
        swipeDownGesture.direction = .down
        view.addGestureRecognizer(swipeUpGesture)
        view.addGestureRecognizer(swipeDownGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sliderButtonDidTouchUpInside(_:)))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .clear
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.roundCorners([.topLeft, .topRight], radius: 30.0)
        return view
    }()
    
    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(frame: .zero)
        setUpLayout()
        setInitialProperties()
        textView.alwaysBounceVertical = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
//        roundCorners([.topLeft, .topRight], radius: 30.0)
    }
    
    func setInitialProperties() {
        alpha = 0
    }
    
    // MARK: SubtitleView - Action methods
    @objc func closeButtonDidTouchUpInside(_ sender: UIButton) {
        delegate?.closeButtonDidTouchUpInside()
    }
    
    @objc func sliderButtonDidTouchUpInside(_ sender: UIButton) {
        delegate?.sliderButtonDidTouchUpInside()
    }
    
    @objc func maximizeSubtitleView(_ sender: UIButton) {
        delegate?.maximizeSubtitleView()
    }
    
    @objc func minimizeSubtitleView(_ sender: UIButton) {
        delegate?.minimizeSubtitleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: SubtitleView - Layout
extension SubtitleView {
    func setUpLayout() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.leading.equalTo(32)
            $0.top.equalToSuperview()
        }
        closeButton.layer.cornerRadius = 15
        
        addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
        mainView.layer.cornerRadius = 30
        
        mainView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalTo(snp.leading).offset(24)
            $0.top.equalToSuperview().offset(32)
            $0.trailing.equalTo(snp.trailing).offset(-24)
            $0.bottom.equalTo(snp.bottom)
        }
        
        mainView.addSubview(sliderButton)
        let height: CGFloat = 8
        sliderButton.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(height)
            $0.top.equalToSuperview().offset(height)
            $0.centerX.equalToSuperview()
        }
        sliderButton.layer.cornerRadius = height / 2
        
        mainView.addSubview(expanderView)
        expanderView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        mainView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
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
        let titleAttributedText = NSMutableAttributedString(string: "Ordering", attributes: titleTextAttributes)
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
        let titleAttributedText = NSMutableAttributedString(string: "Operation", attributes: titleTextAttributes)
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
        let titleAttributedText = NSMutableAttributedString(string: "Big O", attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
    }
}
