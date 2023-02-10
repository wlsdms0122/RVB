//
//  SignedOutView.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import SnapKit
import Resource
import RxSwift
import RxCocoa

final class SignedOutView: UIView {
    // MARK: - View
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = R.Localizable.signedOutTitle
        view.font = .preferredFont(forTextStyle: .title1, compatibleWith: nil)
        view.textColor = .label
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = R.Localizable.signedOutDescription
        view.font = .preferredFont(forTextStyle: .subheadline, compatibleWith: nil)
        view.textColor = .systemGray
        
        return view
    }()
    
    private let titleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        
        return view
    }()
    
    let playerANameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = R.Localizable.signedOutPlayerATextFieldPlaceholder
        view.clearButtonMode = .whileEditing
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.spellCheckingType = .no
        
        return view
    }()
    
    private let playerANameContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    let playerBNameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = R.Localizable.signedOutPlayerBTextFieldPlaceholder
        view.clearButtonMode = .whileEditing
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.spellCheckingType = .no
        
        return view
    }()
    
    private let playerBNameContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.gray.cgColor
        
        return view
    }()
    
    private let textFieldStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        
        return view
    }()
    
    let quickStartButton: UIButton = {
        let view = UIButton(configuration: .borderedTinted())
        view.setTitle(R.Localizable.signedOutQuickStartButtonTitle, for: .normal)
        
        return view
    }()
    
    let signInButton: UIButton = {
        let view = UIButton(configuration: .filled())
        view.setTitle(R.Localizable.signedOutSignInButtonTitle, for: .normal)
        
        return view
    }()
    
    private let actionStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()

    // MARK: - Property
    private let disposeBag = DisposeBag()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Public

    // MARK: - Private
    private func setUp() {
        setUpLayout()
        setUpState()
        setUpAction()
    }
    
    private func setUpLayout() {
        [
            titleLabel,
            descriptionLabel
        ]
            .forEach { titleStackView.addArrangedSubview($0) }
        
        [
            playerANameTextField
        ]
            .forEach { playerANameContainerView.addSubview($0) }
        
        playerANameTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(16)
        }
        
        [
            playerBNameTextField
        ]
            .forEach { playerBNameContainerView.addSubview($0) }
        
        playerBNameTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(16)
        }
        
        [
            playerANameContainerView,
            playerBNameContainerView
        ]
            .forEach { textFieldStackView.addArrangedSubview($0) }
        
        [
            titleStackView,
            textFieldStackView
        ]
            .forEach { contentStackView.addArrangedSubview($0) }
        
        [
            quickStartButton,
            signInButton
        ]
            .forEach { actionStackView.addArrangedSubview($0) }
        
        quickStartButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        signInButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        [
            contentStackView,
            actionStackView
        ]
            .forEach { addSubview($0) }
        
        contentStackView.snp.makeConstraints {
            $0.trailing.leading.equalTo(safeAreaLayoutGuide)
                .inset(16)
            $0.centerY.equalToSuperview()
                .offset(-64)
        }
        
        actionStackView.snp.makeConstraints {
            $0.trailing.leading.equalTo(safeAreaLayoutGuide)
                .inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide)
                .inset(16)
        }
    }
    
    private func setUpState() {
        backgroundColor = .systemBackground
    }
    
    private func setUpAction() {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        endEditing(true)
    }
}
