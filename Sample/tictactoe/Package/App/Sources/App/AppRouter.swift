//
//  AppRouter.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import RVB
import Root

protocol AppRoutable: Routable {
    /// Route to the `Root` module.
    func routeToRoot(with parameter: RootParameter) -> any RootControllable
}

final class AppRouter: AppRoutable {
    // MARK: - Property
    
    // MARK: - Builder
    private let rootBuilder: any RootBuildable
    
    // MARK: - Initializer
    init(rootBuilder: any RootBuildable) {
        self.rootBuilder = rootBuilder
    }
    
    // MARK: - Route
    func routeToRoot(with parameter: RootParameter) -> any RootControllable {
        rootBuilder.build(with: parameter)
    }
}
