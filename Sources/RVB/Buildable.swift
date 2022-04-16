//
//  Builder.swift
//  
//
//  Created by jsilver on 2021/03/21.
//

/// Define the model dependencies the module will use.
public protocol Dependency { }

/// Define the parameters the module will use at start.
public protocol Parameter { }

/// Define build function.
/// e.g. func build(parameter: Parameter) -> Controllable
public protocol Buildable { }

open class Builder<Dependency>: Buildable {
    public let dependency: Dependency
    
    public init(_ dependency: Dependency) {
        self.dependency = dependency
    }
}
