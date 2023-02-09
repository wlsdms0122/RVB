//
//  Resource+Image.swift
//  
//
//  Created by JSilver on 2022/12/28.
//

import UIKit

public extension Resource {
    enum Image { }
}

public extension Resource.Image {
    static var board: UIImage { UIImage(named: "board", in: .module, compatibleWith: nil)! }
}
