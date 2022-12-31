//
//  LaunchViewController.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import RVB
import ReactorKit

public protocol LaunchControllable: UIViewControllable, UINavigationControllerDelegate {
    var disposeBag: DisposeBag { get }
    
    /// Launch completed.
    var completed: Observable<LaunchState> { get }
}

final class LaunchViewController: UIViewController, View, LaunchControllable {
    // MARK: - View
    private let root = LaunchView()

    // MARK: - Property
    var router: (any LaunchRoutable)?
    
    var disposeBag = DisposeBag()

    // MARK: - Initializer

    // MARK: - Lifecycle
    override func loadView() {
        view = root
    }
    
    func bind(reactor: LaunchViewReactor) {
        // MARK: State

        // MARK: Action
        reactor.action.onNext(.launch)
    }
    
    // MARK: - Public

    // MARK: - Private
}

extension LaunchViewController {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        LaunchAnimator()
    }
}

extension LaunchViewController {
    var completed: Observable<LaunchState> {
        guard let reactor = reactor else { return .empty() }
        
        return reactor.pulse(\.$launchCompleted)
            .compactMap { $0 }
    }
}
