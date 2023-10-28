//___FILEHEADER___

import UIKit
import RVB

public protocol ___VARIABLE_productName___Controllable: UIViewControllable {
    
}

final class ___VARIABLE_productName___ViewController: UIViewController, ___VARIABLE_productName___Controllable {
    // MARK: - View
    private let root = ___VARIABLE_productName___View()

    // MARK: - Property
    var router: (any ___VARIABLE_productName___Routable)?

    // MARK: - Initializer

    // MARK: - Lifecycle
    override func loadView() {
        view = root
    }

    // MARK: - Public

    // MARK: - Private
}
