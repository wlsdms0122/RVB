//
//  RouteModifier.swift
//  
//
//  Created by JSilver on 2022/12/29.
//

import SwiftUI

struct RouteModifier<
    Parameter: Hashable,
    Destination: View
>: ViewModifier {
    // MARK: - Property
    @Binding
    private var route: Bool
    @Binding
    private var parameter: Parameter?
    
    private let destination: (Parameter) -> Destination
    
    // MARK: - Initializer
    init(
        _ parameter: Binding<Parameter?>,
        @ViewBuilder destination: @escaping (Parameter) -> Destination
    ) {
        self._route = Binding(
            get: {
                parameter.wrappedValue != nil
            },
            set: {
                guard !$0 else { return }
                parameter.wrappedValue = nil
            }
        )
        self._parameter = parameter
        self.destination = destination
    }
    
    // MARK: - Lifecycle
    func body(content: Content) -> some View {
        // `.navigationDestination` on iOS 16.0+ should use under the `NavigationStack` or `NavigationSplitView`.
        // But `NavigationStack` or `NaivgationSplitView` that include `NavigationView` of iOS 15.0- create a new `UIKitNavigationController` independent of parent navigation controller.
        // Behavior is different from `NavigationLink` up to iOS 15 for that reason.
        // Basically `NavigationLink` can operate under the `UINavigationController` of `UIKit`. Therefore parent navgiation controller(`UIKit`)'s `children` contain destination view.
        // But `.navigationDestination` needs `NavigationStack` or `NavigationSplitView` first.
        // And it make a new navigation controller. Thus parent navigation controller(`UIKit`)'s `chilren` is created navigation controller by `NavigationStack`.
        
        // if #available(iOS 16.0, *) {
        //     content
        //         .navigationDestination(
        //             isPresented: $route
        //         ) {
        //             if let parameter {
        //                 destination(parameter)
        //             } else {
        //                 EmptyView()
        //             }
        //         }
        // } else {
            content.overlay(
                NavigationLink(
                    isActive: $route
                ) {
                    if let parameter {
                        destination(parameter)
                    } else {
                        EmptyView()
                    }
                } label: {
                    EmptyView()
                }
            )
        // }
    }
    
    // MARK: - Public
    
    // MARK: - Private
}

extension View {
    public func route<
        Parameter: Hashable,
        Destination: View
    >(
        _ parameter: Binding<Parameter?>,
        @ViewBuilder destination: @escaping (Parameter) -> Destination
    ) -> some View {
        modifier(
            RouteModifier(
                parameter,
                destination: destination
            )
        )
    }
}
