//
//  FlowCoordinator.swift
//  Cookly
//
//  Created by Davit Natenadze on 22.01.24.
//

import SwiftUI

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func showRegistrationView()
    func goBackToLoginView()
    func showTabBarController()
    func pushTestVC()
}

final class FlowCoordinator:  Coordinator {
    
    // MARK: - Properties
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        showRootView()
    }
    
    private func showRootView() {
        let loginView = LoginView(coordinator: self)
        let hostingView = UIHostingController(rootView: loginView)
        navigationController.pushViewController(hostingView, animated: true)
    }
    
    func showRegistrationView() {
        let registration = RegistrationView(coordinator: self)
        let hostingView = UIHostingController(rootView: registration)
        navigationController.pushViewController(hostingView, animated: true)
    }
    
    func goBackToLoginView() {
        navigationController.popViewController(animated: true)
    }
    
    func showTabBarController() {
        let controller = TabBarController(coordinator: self)
        controller.navigationItem.hidesBackButton = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func pushTestVC() {
        let controller = PromptViewController()
        navigationController.pushViewController(controller, animated: true)
    }
}

