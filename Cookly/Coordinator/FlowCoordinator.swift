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
        showLoginAsRootView()
    }
    
    func logoutUser() {
        showLoginAsRootView()
    }
    
    private func showLoginAsRootView() {
        let authManager = AuthCredentialsManager()
        let viewModel = LoginViewModel(authManager: authManager)
        viewModel.delegate = self
        let loginView = LoginView(viewModel: viewModel)
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
        let authManager = AuthCredentialsManager()
        let viewModel = RegistrationViewModel(authManager: authManager)
        viewModel.delegate = self
        let registration = RegistrationView(viewModel: viewModel)
        let hostingView = UIHostingController(rootView: registration)
        navigationController.pushViewController(hostingView, animated: true)
    }
    
    func goBackToLoginView() {
        navigationController.popViewController(animated: true)
    }
    
    func pushRecipeViewController(recipe: Recipe) {
        let viewModel = RecipeViewModel()
        let controller = RecipeViewController(recipe: recipe, viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func pushPromptViewController() {
        let viewModel = PromptViewModel(coordinator: self)
        let controller = PromptViewController(viewModel: viewModel)
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

extension FlowCoordinator: AuthDelegate {
    func loginViewDidTapLogin() {
        showTabBarAsRoot()
    }
    
    func registrationViewDidTapRegister() {
        goBackToLoginView()
    }
    
    func loginViewDidTapDontHaveAnAccount() {
        showRegistrationView()
    }
}
