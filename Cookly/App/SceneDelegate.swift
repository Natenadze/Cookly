//
//  SceneDelegate.swift
//  Cookly
//
//  Created by Davit Natenadze on 19.01.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let apiManager = ApiManager()
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = ViewController(apiManager: apiManager)
        window?.makeKeyAndVisible()
    }
    
}
