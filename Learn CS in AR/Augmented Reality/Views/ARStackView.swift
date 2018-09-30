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
    weak var viewController: UIViewController?
    
    // MARK: ARLessonViewController - Reset Objects
    let resetLabel: ARLabel = {
        let label = ARLabel()
        label.text = " "
        return label
    }()
    
    lazy var resetButton: AlternateARButton = {
        let button = AlternateARButton(image: #imageLiteral(resourceName: "reset").withRenderingMode(.alwaysOriginal))
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
        label.text = LocalizedString.ordering
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
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = labelButtonSpacing
        return stackView
    }()
    
    // MARK: ARLessonViewController - Operation Objects
    lazy var operationButton: ARButton = {
        let button = ARButton(image: #imageLiteral(resourceName: "operation"))
        button.addTarget(viewController, action: #selector(ARLessonViewController.operationButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    let operationLabel: ARLabel = {
        let label = ARLabel()
        label.text = LocalizedString.operation
        return label
    }()
    
    lazy var operationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [operationButton, operationLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = labelButtonSpacing
        return stackView
    }()
    
    // MARK: ARLessonViewController - Big O
    lazy var bigOButton: ARButton = {
        let button = ARButton(image: #imageLiteral(resourceName: "bigO"))
        button.addTarget(viewController, action: #selector(ARLessonViewController.bigOButtonDidTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    let bigOLabel: ARLabel = {
        let label = ARLabel()
        label.text = "Big O"
        return label
    }()
    
    lazy var bigOStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bigOButton, bigOLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    // MARK: ARLessonViewController - Stack View
    lazy var bottomRightStackView: UIStackView = {
//        let stackView =
//            UIStackView(arrangedSubviews: [orderingStackView, operationStackView])
        let stackView =
            UIStackView(arrangedSubviews: [orderingStackView, operationStackView])
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init(frame: .zero)
        setUpUI()
        setUpLayout()
        addArrangedSubview(resetStackView)
//        addArrangedSubview(UIView())
        addArrangedSubview(bottomRightStackView)
    }
    
    
    func setUpUI() {
        alignment = .center
        distribution = .equalSpacing
        alpha = 0
    }
    
    func setUpLayout() {
        let buttonLength: Float = 60
        orderingButton.snp.makeConstraints {
            $0.height.equalTo(buttonLength)
        }
        
        operationButton.snp.makeConstraints {
            $0.height.equalTo(buttonLength)
        }
        
        bottomRightStackView.snp.makeConstraints {
            $0.width.equalTo(240)
        }
        
        let alternateButtonLegth = 50
        resetButton.snp.makeConstraints {
            $0.size.equalTo(alternateButtonLegth)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
