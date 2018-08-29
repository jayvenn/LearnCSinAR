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

protocol SubtitleViewDelegate: class {
    func closeButtonDidTouchUpInside()
    func sliderButtonDidTouchUpInside()
    func maximizeSubtitleView()
    func minimizeSubtitleView()
    func refreshSubtitleView()
    func subtitleDidTranslate(y: CGFloat)
}

final class SubtitleView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
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
    
    let titleLabelSpacerView: UIView = {
        return UIView()
    }()
    
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleLabelSpacerView])
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
        return stackView
    }()
    
    let verticalSpacerView: UIView = UIView()
    
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sliderButtonDidTouchUpInside(_:)))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .clear
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        roundCorners([.topLeft, .topRight], radius: 30.0)
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
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            let translation = gestureRecognizer.translation(in: self.superview)
            var transform = CGAffineTransform.identity
            print("Translation:", translation.y)
            transform = transform.translatedBy(x: 0, y: translation.y)
            self.delegate?.subtitleDidTranslate(y: translation.y)
            self.transform = transform
        case .ended:
            let translation = gestureRecognizer.translation(in: self.superview)
            let velocity = gestureRecognizer.velocity(in: self.superview)
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springWithDaming, initialSpringVelocity: initialSpringVelocity, options: .curveEaseOut, animations: {
                self.transform = .identity
                if translation.y < -350 || velocity.y < -500 {  // left: 150
                    self.delegate?.maximizeSubtitleView()
                } else if translation.y > 45 || velocity.y > 500 { // left: 100
                    self.delegate?.minimizeSubtitleView()
                } else {
                    self.delegate?.refreshSubtitleView()
                }
                self.layoutIfNeeded()
            }, completion: { _ in
                
            })
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: SubtitleView - Layout
extension SubtitleView {
    func setUpLayout() {
        addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
        
        mainView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalTo(snp.leading).offset(24)
            $0.top.equalToSuperview().offset(32)
            $0.trailing.equalTo(snp.trailing).offset(-24)
            $0.bottom.equalTo(snp.bottom)
        }
        
        mainView.addSubview(sliderButton)
//        sliderButton.isHidden = true
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
            $0.trailing.equalTo(stackView)
            $0.height.width.equalTo(44)
            $0.centerY.equalTo(titleLabel)
        }
        
        titleLabelSpacerView.snp.makeConstraints {
            $0.width.equalTo(closeButton)
        }
    }
    
    func getTitleLabelFont() -> UIFont {
        let preferredContentSizeCategory = traitCollection.preferredContentSizeCategory
        let titleLabelFont: UIFont
        if preferredContentSizeCategory > .accessibilityMedium {
            titleLabelFont = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: UITraitCollection(displayScale: 36))
        } else {
            titleLabelFont = Font(object: .textViewTitle).instance
        }
        return titleLabelFont
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
        let titleAttributedText = NSMutableAttributedString(string: "Ordering", attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
        titleLabel.accessibilityLabel = "Ordering"
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
                                   NSAttributedStringKey.font: getTitleLabelFont()]
        let titleAttributedText = NSMutableAttributedString(string: "Operation", attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.accessibilityLabel = "Operation"
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
