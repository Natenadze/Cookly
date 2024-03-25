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
    
    // MARK: - Methods
    func register(email: String, password: String) async throws {
        try validateCredentials(email: email, password: password)
        do {
            try await authService.register(email: email, password: password)
            isRegistrationSuccessful = true
        } catch {
            throw AuthError.serverError
        }
    }
    
    // MARK: - Helper
    private func validateCredentials(email: String, password: String) throws {
        guard isEmailValid(email) else {
            throw AuthError.invalidEmail
        }
        
        guard isPasswordCriteriaMet(text: password) else {
            throw AuthError.invalidPassword
        }
    }
    
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

//TODO: - Refactor redundancy
extension RegistrationViewModel {
    
    func isPasswordCriteriaMet(text: String) ->  Bool {
        lengthAndNoSpaceMet(text) &&
        uppercaseMet(text) &&
        lowercaseMet(text) &&
        digitMet(text) &&
        specialCharMet(text)
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return email.range(of: emailPattern, options: .regularExpression) != nil
    }
    
    // MARK: - Password Criteria Methods
    func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }
    
    func noSpaceCriteriaMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    
    func lengthAndNoSpaceMet(_ text: String) -> Bool {
        lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
    
    func uppercaseMet(_ text: String) -> Bool {
        text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    func lowercaseMet(_ text: String) -> Bool {
        text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    
    func digitMet(_ text: String) -> Bool {
        text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    func specialCharMet(_ text: String) -> Bool {
        let pattern = #"[^a-zA-Z0-9]+"#
        return text.range(of: pattern, options: .regularExpression) != nil
    }
}

