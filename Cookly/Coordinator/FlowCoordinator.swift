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
    func pushRecipeViewController(recipe: Recipe)
    func pushPromptViewController()
    func showTabBarAsRoot()
    func logoutUser()
}

final class FlowCoordinator: Coordinator {
    
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
    
    func logoutUser() {
        showRootView()
    }
    
    private func showRootView() {
        let loginView = LoginView(coordinator: self)
        let hostingView = UIHostingController(rootView: loginView)
        navigationController.setViewControllers([hostingView], animated: true)
    }
    
    func showTabBarAsRoot() {
        if LocalState.hasOnboarded {
            let controller = TabBarController(coordinator: self)
            navigationController.viewControllers = [controller]
        } else {
            let onboardingContainerVC = OnboardingContainerVC()
            onboardingContainerVC.delegate = self
            navigationController.viewControllers = [onboardingContainerVC]
        }
        
    }
    
    func showRegistrationView() {
        let registration = RegistrationView(coordinator: self)
        let hostingView = UIHostingController(rootView: registration)
        navigationController.pushViewController(hostingView, animated: true)
    }
    
    func goBackToLoginView() {
        navigationController.popViewController(animated: true)
    }
    
    func pushRecipeViewController(recipe: Recipe) {
        let controller = RecipeViewController(recipe: recipe)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func pushPromptViewController() {
        let controller = PromptViewController(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
}


// MARK: - Extension
extension FlowCoordinator: OnboardingContainerVCDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        showTabBarAsRoot()
    }
    
}
