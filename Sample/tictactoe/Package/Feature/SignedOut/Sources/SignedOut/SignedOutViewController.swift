//
//  SignedOutViewController.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import RVB
import Deeplinker
import ReactorKit
import RxCocoa
import Game
import Resource

public protocol SignedOutControllable: UIViewControllable {
    var disposeBag: DisposeBag { get }
    
    /// Signed in.
    var signedIn: Observable<Players> { get }
}

final class SignedOutViewController: UIViewController, View, SignedOutControllable {
    // MARK: - View
    private let root = SignedOutView()
    
    private var playerANameTextField: UITextField { root.playerANameTextField }
    private var playerBNameTextField: UITextField { root.playerBNameTextField }
    private var signInButton: UIButton { root.signInButton }
    private var quickStartButton: UIButton { root.quickStartButton }

    // MARK: - Property
    var router: (any SignedOutRoutable)?
    var deeplinker: (any Deeplinkable)?
    
    var disposeBag = DisposeBag()

    // MARK: - Initializer

    // MARK: - Lifecycle
    override func loadView() {
        view = root
    }
    
    func bind(reactor: SignedOutViewReactor) {
        // MARK: State
        // Error
        reactor.pulse(\.$error)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] in self?.presentErrorAlert(error: $0) })
            .disposed(by: disposeBag)

        // MARK: Action
        // Player A name
        playerANameTextField.rx.text
            .orEmpty
            .map { .updatePlayerAName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Player B name
        playerBNameTextField.rx.text
            .orEmpty
            .map { .updatePlayerBName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Quick start
        quickStartButton.rx.tap
            .compactMap { URL(string: "tictactoe://game?playerA=iPhone&playerB=iPad") }
            .subscribe(onNext: { [weak self] in self?.deeplinker?.handle(url: $0) })
            .disposed(by: disposeBag)
        
        // Register players
        signInButton.rx.tap
            .map { .signIn }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    // MARK: - Public

    // MARK: - Private
    private func presentErrorAlert(error: Error) {
        let viewController = UIAlertController(
            title: R.Localizable.errorTitle,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        viewController.addAction(
            .init(
                title: R.Localizable.okay,
                style: .default
            )
        )
        
        present(viewController, animated: true)
    }
}

extension SignedOutViewController {
    var signedIn: Observable<Players> {
        guard let reactor = reactor else { return .empty() }
        
        return reactor.pulse(\.$didSignIn)
            .compactMap { $0 }
    }
}
