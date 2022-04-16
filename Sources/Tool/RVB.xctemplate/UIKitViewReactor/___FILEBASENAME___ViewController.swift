//___FILEHEADER___

import UIKit
import RVB
import ReactorKit

public protocol ___VARIABLE_productName___Controllable: UIViewControllable {
    var disposeBag: DisposeBag { get }
}

final class ___VARIABLE_productName___ViewController: UIViewController, View, ___VARIABLE_productName___Controllable {
    // MARK: - View
    private let root = ___VARIABLE_productName___View()

    // MARK: - Property
    var router: ___VARIABLE_productName___Routable?
    var disposeBag = DisposeBag()

    // MARK: - Initializer

    // MARK: - Lifecycle
    override func loadView() {
        view = root
    }

    // MARK: - Public
    func bind(reactor: ___VARIABLE_productName___ViewReactor) {
        // MARK: State

        // MARK: Action
        
    }

    // MARK: - Private
}
