//
//  EmptyView.swift
//  Learn CS in AR
//
//  Created by Macbook on 8/13/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

class EmptyView: UIView {
    
    let titleLabel: UILabel = {
        let text = "Course not yet available.\nContribute at"
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.accessibilityLabel = text
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cyan
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    let actionButton: UIButton = {
        let frame = CGRect(x: 0, y: 0, width: 280, height: 50)
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Action", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
//        setupActionButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(45)
            $0.leading.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().offset(-35)
        }
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(35)
            $0.bottom.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(-35)
        }
    }
    
//    func setupActionButton() {
//        addSubview(actionButton)
//        actionButton.snp.makeConstraints {
//            $0.bottom.equalToSuperview().offset(-84)
//            $0.centerX.equalToSuperview()
//            $0.width.equalTo(280)
//            $0.height.equalTo(50)
//        }
//    }
    
    func setImageView() {
        
    }
    
    func addActionButton(_ button: UIButton) {
        addSubview(button)
        let sideOffset = 15
        button.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(sideOffset)
            $0.trailing.equalToSuperview().offset(-sideOffset)
            $0.bottom.equalToSuperview().offset(-113)
        }
    }
}
