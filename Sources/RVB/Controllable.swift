//
//  Controllable.swift
//  
//
//  Created by jsilver on 2021/04/11.
//


/// Define input & output interface to communicate between parent and child.
@MainActor
public protocol Controllable { }

#if os(iOS)
import UIKit

public protocol UIViewControllable: Controllable where Self: UIViewController { }
#endif

#if os(macOS)
import AppKit

public protocol NSViewControllable: Controllable where Self: NSViewController { }
#endif

#if canImport(SwiftUI)
import SwiftUI

public protocol ViewControllable: Controllable where Self: View { }
#endif
