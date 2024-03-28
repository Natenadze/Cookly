//
//  RegistrationView.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//


import SwiftUI

struct RegistrationView: View {
    
    // MARK: - Properties
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var errorMessage: String = ""
    @State private var showErrorBanner: Bool = false
    
    @ObservedObject private var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        mainContent
    }
}


// MARK: - Extensions
private extension RegistrationView {
    var mainContent: some View {
        ZStack {
            BackgroundViewRepresentable()
                .ignoresSafeArea()
            
            VStack {
                ErrorBannerView(isVisible: $showErrorBanner, message: errorMessage)
                    .padding()
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 16) {
                textFieldStack
                signUpButton
            }
            .padding(.horizontal, 16)
        }
        
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
    
    var signUpButton: some View {
        Button("Sign Up", action: SignUpButtonTapped)
            .buttonStyle(AuthButtonStyle())
    }
}

// MARK: - Methods Extension
extension RegistrationView {
    
    func SignUpButtonTapped() {
        Task {
            do {
                try await viewModel.register(email: emailInput, password: passwordInput)
            } catch {
                showError(error: error)
            }
        }
    }
}

extension RegistrationView {
    
    func showError(error: Error) {
        if let authError = error as? AuthError {
            DispatchQueue.main.async {
                errorMessage = viewModel.errorMessage(for: authError)
                showErrorBanner = true
            }
        }
    }
}

// MARK: - Preview
#Preview {
    RegistrationView(viewModel: RegistrationViewModel(authManager: AuthCredentialsManager()))
}
