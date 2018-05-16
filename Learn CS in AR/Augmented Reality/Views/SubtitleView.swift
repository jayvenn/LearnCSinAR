//
//  SubtitleView.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/16/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

protocol SubtitleDelegate: class {
    func closeButtonDidTouchUpInside()
}

class SubtitleView: UIView {
    
    let titleLabel = UILabel()
    
    var lesson: Lesson
    weak var delegate: SubtitleDelegate?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "arrow down"), for: .normal)
        button.addTarget(self, action: #selector(SubtitleView.closeButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textView = SubtitleTextView(lesson: lesson)
    
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, closeButton])
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, textView])
        return stackView
    }()
    
    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(frame: .zero)
        setInitialProperties()
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
            make.leading.equalTo(snp.leading)
            make.top.equalTo(snp.top)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
        }
    }
}
