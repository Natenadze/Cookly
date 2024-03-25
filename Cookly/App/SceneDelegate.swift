//
//  SceneDelegate.swift
//  Cookly
//
//  Created by Davit Natenadze on 19.01.24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
//    @Injected(\.networkProvider) var apiManager: NetworkProviding
    @Injected(\.userService) var userService: UserServiceProviding
    var window: UIWindow?
    private var flowCoordinator: Coordinator?
    
    // MARK: - Scene
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        flowCoordinator = FlowCoordinator(navigationController: navigationController)
        
        Task {
            if await userService.checkIfUserIsSignedIn() {
                flowCoordinator?.showTabBarAsRoot()
            } else {
                flowCoordinator?.start()
            }
        }
        
        window?.rootViewController = navigationController
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}
