//
//  FlowCoordinator.swift
//  Cookly
//
//  Created by Davit Natenadze on 22.01.24.
//

import SwiftUI

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
    func showRegistrationView()
    func goBackToLoginView()
    func showTabBarController()
}

final class FlowCoordinator: ObservableObject, Coordinator {
    
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
        let controller = TabBarController()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController.present(controller, animated: true)
    }
}

