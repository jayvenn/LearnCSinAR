//
//  ARStackView.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/8/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

class ARStackView: UIStackView {

    let labelButtonSpacing: CGFloat = 2
    let viewController: UIViewController
    
    // MARK: ARLessonViewController - Reset Objects
    let resetLabel: ARLabel = {
        let label = ARLabel()
        label.text = " "
        return label
    }()
    
    lazy var resetButton: AlternateARButton = {
        let button = AlternateARButton(image: #imageLiteral(resourceName: "reset"))
        button.addTarget(viewController, action: #selector(ARLessonViewController.resetButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var resetStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resetButton, resetLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = labelButtonSpacing
        return stackView
    }()
    
    // MARK: ARLessonViewController - Ordering Objects
    let orderingLabel: ARLabel = {
        let label = ARLabel()
        label.text = "Ordering"
        return label
    }()
    
    lazy var orderingButton: ARButton = {
        let button = ARButton(image: #imageLiteral(resourceName: "ordering"))
        button.addTarget(viewController, action: #selector(ARLessonViewController.orderingButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var orderingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [orderingButton, orderingLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = labelButtonSpacing
        return stackView
    }()
    
    let bigOLabel: ARLabel = {
        let label = ARLabel()
        label.text = "Big O"
        return label
    }()
    
    // MARK: ARLessonViewController - Operation Objects
    lazy var operationButton: ARButton = {
        let button = ARButton(image: #imageLiteral(resourceName: "operation"))
        button.addTarget(viewController, action: #selector(ARLessonViewController.operationButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    let operationLabel: ARLabel = {
        let label = ARLabel()
        label.text = "Operation"
        return label
    }()
    
    lazy var operationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [operationButton, operationLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = labelButtonSpacing
        return stackView
    }()
    
    // MARK: ARLessonViewController - Big O
    lazy var bigOButton: ARButton = {
        let button = ARButton(image: #imageLiteral(resourceName: "bigO"))
        button.addTarget(viewController, action: #selector(ARLessonViewController.bigOButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var bigOStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bigOButton, bigOLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        return stackView
    }()
    
    // MARK: ARLessonViewController - Stack View
    lazy var bottomRightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [orderingStackView, operationStackView, bigOStackView])
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init(frame: .zero)
        setUpUI()
        setUpLayout()
        addArrangedSubview(resetStackView)
        addArrangedSubview(UIView())
        addArrangedSubview(bottomRightStackView)
    }
    
    
    func setUpUI() {
        alignment = .center
        distribution = .equalSpacing
        alpha = 0
    }
    
    func setUpLayout() {
        let buttonLength = 60
        orderingButton.snp.makeConstraints { (make) in
            make.size.equalTo(buttonLength)
        }
        
        operationButton.snp.makeConstraints { (make) in
            make.size.equalTo(buttonLength)
        }
        
        bigOButton.snp.makeConstraints { (make) in
            make.size.equalTo(buttonLength)
        }
        
        bottomRightStackView.snp.makeConstraints { (make) in
            make.width.equalTo(220)
        }
        
        let alternateButtonLegth = 50
        resetButton.snp.makeConstraints { (make) in
            make.size.equalTo(alternateButtonLegth)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
