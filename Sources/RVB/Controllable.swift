//
//  Controllable.swift
//  
//
//  Created by jsilver on 2021/04/11.
//

import UIKit

/// Define input & output interface to communicate between parent and child.
public protocol Controllable { }

public protocol UIViewControllable: Controllable where Self: UIViewController { }

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
public protocol ViewControllable: Controllable where Self: View { }
#endif
