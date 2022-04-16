//___FILEHEADER___

import RVB
import SwiftUI

public protocol ___VARIABLE_productName___Controllable: ViewControllable {
    
}

struct ___VARIABLE_productName___View<Routable: ___VARIABLE_productName___Routable>: View, ___VARIABLE_productName___Controllable {
    // MARK: - View
    var body: some View {
        Text("Hello World!")
    }

    // MARK: - Property
    @StateObject
    private var router: Routable

    // MARK: - Initializer
    init(router: Routable) {
        self._router = .init(wrappedValue: router)
    }
    
    // MARK: - Lifecycle

    // MARK: - Public

    // MARK: - Private
}