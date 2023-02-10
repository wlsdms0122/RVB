//
//  LaunchView.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import SnapKit
import Resource

final class LaunchView: UIView {
    // MARK: - View
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = R.Localizable.appName
        view.font = .preferredFont(forTextStyle: .largeTitle)
        
        return view
    }()

    // MARK: - Property

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    // MARK: - Public

    // MARK: - Private
    private func setUp() {
        setUpLayout()
        setUpState()
        setUpAction()
    }
    
    private func setUpLayout() {
        [
            titleLabel
        ]
            .forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setUpState() {
        backgroundColor = .white
    }
    
    private func setUpAction() {
        
    }
}
