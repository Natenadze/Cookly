//
//  FlowCoordinator.swift
//  Cookly
//
//  Created by Davit Natenadze on 22.01.24.
//

import SwiftUI

protocol Coordinator {
    func start()
    func showRegistrationView()
    func goBackToLoginView()
    func showTabBarController()
}

final class FlowCoordinator: ObservableObject, Coordinator {
    
    // MARK: - Properties
    private let window: UIWindow
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Methods
    func showRegistrationView() {
        let registration = RegistrationView(coordinator: self)
        let hostingView = UIHostingController(rootView: registration)
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(hostingView, animated: true)
        }
    }
    
    func goBackToLoginView() {
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func showTabBarController() {
        let controller = TabBarController()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        window.rootViewController?.present(controller, animated: true)
    }
}


// MARK: - Extension
extension FlowCoordinator {
    func start() {
        showRootView()
    }
    
    private func showRootView() {
        let loginView = LoginView(coordinator: self)
        let hostingView = UIHostingController(rootView: loginView)
        let navigationController = UINavigationController(rootViewController: hostingView)
        window.rootViewController = navigationController
    }
}
