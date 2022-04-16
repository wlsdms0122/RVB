//___FILEHEADER___

import RVB

public struct ___VARIABLE_productName___Dependency {
    // MARK: - Property
    
    // MARK: - Initializer
    public init() { }
}

public struct ___VARIABLE_productName___Parameter {
    // MARK: - Property
    
    // MARK: - Initializer
    public init() { }
}

public protocol ___VARIABLE_productName___Buildable: Buildable {
    func build(with parameter: ___VARIABLE_productName___Parameter) -> ___VARIABLE_productName___Controllable
}

public final class ___VARIABLE_productName___Builder: Builder<___VARIABLE_productName___Dependency>, ___VARIABLE_productName___Buildable {
    public func build(with parameter: ___VARIABLE_productName___Parameter) -> ___VARIABLE_productName___Controllable {
        let viewController = ___VARIABLE_productName___ViewController()
        let router = ___VARIABLE_productName___Router()
        
        // DI
        viewController.router = router
        
        return viewController
    }
}
