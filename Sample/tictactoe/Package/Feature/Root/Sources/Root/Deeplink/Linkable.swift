//
//  Linkable.swift
//  
//
//  Created by JSilver on 2023/02/07.
//

import Foundation
import Deeplinker

protocol Linkable {
    var url: String { get }
    
    func action(url: URL, parameter: Parameter, query: Query) -> Bool
}

extension Linkable {
    var link: Deeplink? {
        .init(url: url, action: action)
    }
}
