//
//  NSObject+name.swift
//  
//
//  Created by JSilver on 2022/12/29.
//

import Foundation

extension NSObject {
    public static var name: String { String(describing: self) }
}
