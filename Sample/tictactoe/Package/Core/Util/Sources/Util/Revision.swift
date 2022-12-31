//
//  Revision.swift
//
//
//  Created by jsilver on 2021/03/21.
//

import Foundation

@propertyWrapper
public struct Revision<T>: Equatable {
    public private(set) var revision: UInt = 0
    public private(set) var value: T {
        didSet { revision += 1 }
    }
    
    public var projectedValue: Self { self }
    
    public var wrappedValue: T {
        get { value }
        set { value = newValue }
    }

    public init(wrappedValue: T) {
        value = wrappedValue
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.revision == rhs.revision
    }
}
