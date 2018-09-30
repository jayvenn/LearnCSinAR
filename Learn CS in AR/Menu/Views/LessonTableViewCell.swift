//
//  LessonTableViewCell.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    var lesson: Lesson! {
        didSet {
            setDescriptionLabelText()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        selectionStyle = .none
    }
    
    fileprivate func setUpLayout() {
        addSubviews(views: [descriptionLabel])
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(snp.topMargin)
            $0.leading.equalTo(snp.leadingMargin).offset(8)
            $0.trailing.equalTo(snp.trailingMargin).offset(-8)
            $0.bottom.equalTo(snp.bottomMargin)
        }
    }
    
    fileprivate func setDescriptionLabelText() {
        let nameTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                  NSAttributedString.Key.font: FontManager.shared.titleFont]
        let nameAttributedText = NSMutableAttributedString(string: "\(lesson.name.rawValue)\n", attributes: nameTextAttributes)
        
        let addressTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)]
        let addressAttributedText = NSMutableAttributedString(string: "\n\n",
                                                              attributes: addressTextAttributes)
        nameAttributedText.append(addressAttributedText)
        
        descriptionLabel.attributedText = nameAttributedText
    }
    
    func configureCell(lesson: Lesson) {
        self.lesson = lesson
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
