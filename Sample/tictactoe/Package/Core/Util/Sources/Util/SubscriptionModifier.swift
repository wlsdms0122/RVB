//
//  SubscriptionModifier.swift
//
//
//  Created by jsilver on 2022/06/13.
//
import SwiftUI
import Combine

/// Adds an action to perform when this view detects data emitted by the given publisher.
///
/// Modifier's behavior is simillar with `onReceive(_:perform:)`. But it keep subscription through this view's lifecycle.
/// In contrast, `onReceive` keep subscription until this view re-rendered.
struct SubscriptionModifier<P: Publisher>: ViewModifier where P.Failure == Never {
    // MARK: - Property
    @StateObject
    private var wrapper: PublisherWrapper<P>
    private let action: (P.Output) -> Void
    
    // MARK: - Initializer
    public init(
        _ publisher: P,
        perform action: @escaping (P.Output) -> Void
    ) {
        self._wrapper = .init(wrappedValue: PublisherWrapper(publisher))
        self.action = action
    }
    
    // MARK: - Public
    func body(content: Content) -> some View {
        content.onReceive(wrapper.publisher, perform: action)
    }
    
    // MARK: - Private
}

class PublisherWrapper<P: Publisher>: ObservableObject where P.Failure == Never {
    // MARK: - Property
    let publisher: P
    
    // MARK: - Initializer
    init(_ publisher: P) {
        self.publisher = publisher
    }
    
    // MARK: - Public
    
    // MARK: - Private
}

public extension View {
    func subscribe<P: Publisher>(
        _ publisher: P,
        perform action: @escaping (P.Output) -> Void
    ) -> some View where P.Failure == Never {
        modifier(SubscriptionModifier(publisher, perform: action))
    }
}
