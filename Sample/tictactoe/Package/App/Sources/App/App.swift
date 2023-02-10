//
//  App.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import RVB
import Deeplinker

public protocol AppControllable: AnyObject, Controllable {
    var window: UIWindow? { get }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    )
    
    func scene(
        _ scene: UIScene,
        openURLContexts URLContexts: Set<UIOpenURLContext>
    )
}

final class App: AppControllable {
    // MARK: - Property
    var window: UIWindow?
    
    var router: any AppRoutable
    private var deeplinker: Deeplinkable?
    
    // MARK: - Initializer
    init(router: any AppRoutable) {
        self.router = router
    }
    
    // MARK: - Lifecycle
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let root = router.routeToRoot(with: .init())
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = root
        window.makeKeyAndVisible()
        
        if let url = connectionOptions.urlContexts.first?.url {
            root.handle(url: url)
        }
        
        self.window = window
        self.deeplinker = root
    }
    
    func scene(
        _ scene: UIScene,
        openURLContexts URLContexts: Set<UIOpenURLContext>
    ) {
        guard let url = URLContexts.first?.url else { return }
        deeplinker?.handle(url: url)
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
