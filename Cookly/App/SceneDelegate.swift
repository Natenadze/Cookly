//
//  SceneDelegate.swift
//  Cookly
//
//  Created by Davit Natenadze on 19.01.24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var flowCoordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        flowCoordinator = FlowCoordinator(window: window!)
        //TODO: - add logic if user is already signed in
        flowCoordinator?.start()
        window?.makeKeyAndVisible()
    }
}
