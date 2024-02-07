//
//  AuthenticationViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    
    // MARK: - Properties
    @Injected(\.networkProvider) var apiManager: NetworkProviding
    @Published var isRegistrationSuccessful = false
   
    // MARK: - Methods
    func register(email: String, password: String) throws {
        Task { await apiManager.register(email: email, password: password) }
    } 
    
    func login(email: String, password: String) throws {
        Task { await apiManager.login(email: email, password: password) }
    }
    
    func loginWithGoogle() async throws {
        Task { await apiManager.loginWithGoogle() }
    }
    
}


// MARK: - Extension Password Criteria Methods
extension AuthenticationViewModel {
    
    func isPasswordCriteriaMet(text: String) ->  Bool {
        lengthAndNoSpaceMet(text) &&
        uppercaseMet(text) &&
        lowercaseMet(text) &&
        digitMet(text) &&
        specialCharMet(text)
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
