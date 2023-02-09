//
//  SceneDelegate.swift
//  todo
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import App

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Property
    private var window: UIWindow? { app?.window }
    
    private var app: AppControllable?
    
    // MARK: - Lifecycle
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let app = AppBuilder(.init())
            .build(with: .init())
        self.app = app
        
        app.scene(scene, willConnectTo: session, options: connectionOptions)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        app?.scene(scene, openURLContexts: URLContexts)
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
