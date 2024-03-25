//
//  LoginViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation


final class LoginViewModel {
    
    // MARK: - Properties
    @Injected(\.authService) var authService: AuthProviding
    weak var delegate: AuthDelegate?
    private let authManager: AuthCredentialsManager
    
    // MARK: - Lifecycle
    init(authManager: AuthCredentialsManager) {
        self.authManager = authManager
    }
    
    // MARK: - Methods
    func login(email: String, password: String) async throws {
        try authManager.validateCredentials(email: email, password: password)
        do {
            try await authService.login(email: email, password: password)
        } catch {
            throw AuthError.invalidCredentials
        }
    }
    
    func loginWithGoogle() async throws {
        do {
            try await authService.loginWithGoogle()
        } catch {
            throw AuthError.serverError
        }
    }
    
    // MARK: - Helpers
//TODO: - Refactor redundancy
    func errorMessage(for error: AuthError) -> String {
        switch error {
        case .invalidCredentials: return "Login Error: Incorrect email or password."
        case .networkError: return "Network error. Please check your connection."
        case .serverError: return "Server error. Please try again later."
        case .unknownError: return "Unknown error occurred."
        case .invalidEmail: return "Invalid email format."
        case .invalidPassword: return "Password does not meet the criteria."
        }
    }
    
}
