//
//  String+Localizable.swift
//  
//
//  Created by JSilver on 2022/12/28.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }
}
