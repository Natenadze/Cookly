//
//  AuthCredentialsManager.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation

final class AuthCredentialsManager {

    // MARK: - Email and Password Validation
    
    func isEmailValid(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return email.range(of: emailPattern, options: .regularExpression) != nil
    }
    
    // Password Criteria Methods
    func validateCredentials(email: String, password: String) throws {
        guard isEmailValid(email) else {
            throw AuthError.invalidEmail
        }
        
        guard isPasswordCriteriaMet(password) else {
            throw AuthError.invalidPassword
        }
    }
    
    func isPasswordCriteriaMet(_ text: String) -> Bool {
        lengthAndNoSpaceMet(text) &&
        uppercaseMet(text) &&
        lowercaseMet(text) &&
        digitMet(text) &&
        specialCharMet(text)
    }
    
    private func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }
    
    private func noSpaceCriteriaMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    
    private func lengthAndNoSpaceMet(_ text: String) -> Bool {
        lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
    
    private func uppercaseMet(_ text: String) -> Bool {
        text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    private func lowercaseMet(_ text: String) -> Bool {
        text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    
    private func digitMet(_ text: String) -> Bool {
        text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    private func specialCharMet(_ text: String) -> Bool {
        let pattern = #"[^a-zA-Z0-9]+"#
        return text.range(of: pattern, options: .regularExpression) != nil
    }
}
