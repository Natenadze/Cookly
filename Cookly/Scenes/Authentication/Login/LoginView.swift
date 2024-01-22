//
//  LoginView.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import SwiftUI

struct LoginView: View {
    
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
private extension LoginView {
    
    var mainContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            textFieldStack
            HStack {
                Spacer()
                Button("Dont't have an account?") {
                    //TODO: - Navigate to registration view
                    print("Dont't have an account tapped")
                }
            }
            LoginButtonView(title: "Login", action: LoginButtonTapped)
            
        }
        .padding(.horizontal, 16)
    }
}


// MARK: - Extension
private extension LoginView {
    
    var textFieldStack: some View {
        VStack {
            AuthTextField(text: $emailInput, placeholder: "Email")
            AuthTextField(text: $passwordInput, placeholder: "Password", isSecure: true)
        }
        .padding(.top, 60)
    }
    
    func LoginButtonView(title: String, action: @escaping () -> Void) -> some View {
        AuthButton(
            title: title,
            action: action,
            isActive: viewModel.isPasswordCriteriaMet(text: passwordInput)
        )
    }
}

// MARK: - Methods Extension
extension LoginView {
    
    func LoginButtonTapped() {
        Task {
            do {
                try viewModel.login(email: emailInput, password: passwordInput)
            } catch {
                print("Login Error")
            }
        }
    }
}

