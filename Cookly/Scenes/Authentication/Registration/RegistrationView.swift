//
//  RegistrationView.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//


import SwiftUI

struct RegistrationView: View {
    
    // MARK: - Properties
    @Injected(\.authViewModel) var viewModel: AuthenticationViewModel
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    
    // MARK: - Body
    var body: some View {
        mainContent
    }
}


// MARK: - Extensions
private extension RegistrationView {
    
    var mainContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            textFieldStack
            SignUpButtonView(title: "Sign Up", action: SignUpButtonTapped)
        }
        .padding(.horizontal, 16)
    }
}


// MARK: - Extension
private extension RegistrationView {
    
    var textFieldStack: some View {
        VStack {
            AuthTextField(text: $emailInput, placeholder: "Email")
            AuthTextField(text: $passwordInput, placeholder: "Password", isSecure: true)
        }
        .padding(.top, 60)
    }
    
    func SignUpButtonView(title: String, action: @escaping () -> Void) -> some View {
        AuthButton(
            title: title,
            action: action,
            isActive: viewModel.isPasswordCriteriaMet(text: passwordInput)
        )
    }
}

// MARK: - Methods Extension
extension RegistrationView {
    
    func SignUpButtonTapped() {
        Task {
            do {
                try viewModel.register(email: emailInput, password: passwordInput)
            }catch {
                print("Registration Error")
            }
        }
    }
}