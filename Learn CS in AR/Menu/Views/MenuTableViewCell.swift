//
//  MenuTableViewCell.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var course: Course! {
        didSet {
            setDescriptionLabelText()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        selectionStyle = .none
    }
    
    fileprivate func setUpLayout() {
        addSubviews(views: [descriptionLabel])
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.topMargin)
            make.leading.equalTo(snp.leadingMargin).offset(8)
            make.trailing.equalTo(snp.trailing).offset(-8)
            make.bottom.equalTo(snp.bottomMargin)
        }
    }
    
    fileprivate func setDescriptionLabelText() {
        let nameTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                  NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        let nameAttributedText = NSMutableAttributedString(string: "\(course.name)\n", attributes: nameTextAttributes)
        
        let addressTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.lightGray,
                                     NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: .regular)]
        let addressAttributedText = NSMutableAttributedString(string: course.description + "\n\n",
                                                              attributes: addressTextAttributes)
        nameAttributedText.append(addressAttributedText)
        descriptionLabel.attributedText = nameAttributedText
    }
    
    func configureCell(course: Course) {
        self.course = course
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
