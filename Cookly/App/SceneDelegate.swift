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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let authHostingController = UIHostingController(rootView: RegistrationView())
        window?.rootViewController = authHostingController
        window?.makeKeyAndVisible()
    }
}
