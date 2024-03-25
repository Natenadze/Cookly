//
//  RegistrationViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation

final class RegistrationViewModel: ObservableObject {
    
    // MARK: - Properties
    @Injected(\.authService) var authService: AuthProviding
    @Published var isRegistrationSuccessful = false
    weak var delegate: AuthDelegate?
    private let authManager: AuthCredentialsManager
    
    // MARK: - LifeCycle
    init(authManager: AuthCredentialsManager) {
        self.authManager = authManager
    }
    
    // MARK: - Methods
    func register(email: String, password: String) async throws {
        try authManager.validateCredentials(email: email, password: password)
        do {
            try await authService.register(email: email, password: password)
            isRegistrationSuccessful = true
        } catch {
            throw AuthError.serverError
        }
    }
    
    // MARK: - Helper
    
    func errorMessage(for error: AuthError) -> String {
        switch error {
        case .invalidCredentials: return "Error: Incorrect email or password."
        case .networkError: return "Network error. Please check your connection."
        case .serverError: return "Server error. Please try again later."
        case .unknownError: return "Unknown error occurred."
        case .invalidEmail: return "Invalid email format."
        case .invalidPassword: return "Password does not meet the criteria."
        }
    }
}
