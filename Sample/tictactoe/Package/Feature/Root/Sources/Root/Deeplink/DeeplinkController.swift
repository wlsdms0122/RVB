//
//  DeeplinkController.swift
//  
//
//  Created by JSilver on 2023/02/07.
//

import Foundation
import Deeplinker
import UIKit

class DeeplinkController: DeferredDeeplinkable {
    // MARK: - Property
    private let deeplinker: Deeplinker
    
    // MARK: - Initializer
    init(root: any RootControllable, canHandler: Bool = true) {
        self.deeplinker = Deeplinker(canHandle: canHandler)
        
        setUpDeeplink([
            GameLink(root),
            ScoreboardLink(root)
        ])
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Public
    @discardableResult
    func handle(url: URL) -> Bool {
        deeplinker.handle(url: url)
    }
    
    func handle() -> Bool {
        deeplinker.handle()
    }
    
    func store(url: URL) {
        deeplinker.store(url: url)
    }
    
    // MARK: - Private
    private func setUpDeeplink(_ links: [Linkable]) {
        links.compactMap(\.link)
            .forEach { deeplinker.addDeeplink($0) }
    }
}
