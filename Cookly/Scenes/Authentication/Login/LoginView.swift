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
    @State private var isLoading: Bool = false
    @State var errorMessage: String = ""
    @State var showErrorBanner: Bool = false
    
    let coordinator: Coordinator
    
    // MARK: - Body
    var body: some View {
        
        ZStack {
            BackgroundViewRepresentable()
                .ignoresSafeArea()
            VStack {
                ErrorBannerView(isVisible: $showErrorBanner, message: errorMessage)
                    .padding()
                Spacer()
            }
            
            VStack(alignment: .leading, spacing:20) {
                textFieldStack
                dontHaveAnAccountButton
                LoginButtonView(title: "Login", action: loginButtonTapped)
                orDivider.padding(.top, 20)
                googleSignInButton.padding(.top, 20)
                
            }
            .padding(.horizontal, 16)
            .padding(.top,80)
            
            if isLoading {
                ZStack {
                    Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                        .scaleEffect(2)
                }
            }
        }
        
    }
    
    func showError(error: Error) {
        if let authError = error as? AuthError {
            DispatchQueue.main.async {
                errorMessage = viewModel.errorMessage(for: authError)
                showErrorBanner = true
            }
        }
    }
}


// MARK: - Extension
private extension LoginView {
    var orDivider: some View {
        HStack {
            line
            Text("Or")
                .font(.headline)
                .foregroundColor(.gray)
            line
        }
    }
    
    var line: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity)
    }
    
    var googleSignInButton: some View {
        Button(action: {
            googleLoginButtonTapped()
        }) {
            HStack {
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                
                Text("Sign in with Google")
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
    
    
    var textFieldStack: some View {
        VStack {
            AuthTextField(text: $emailInput, placeholder: "Email")
            AuthTextField(text: $passwordInput, placeholder: "Password", isSecure: true)
        }
        .padding(.top, 60)
    }
    
    var dontHaveAnAccountButton: some View {
        HStack {
            Spacer()
            
            Button(action: {
                coordinator.showRegistrationView()
            }, label: {
                Text("Dont't have an account?")
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
            })
            
        }
    }
    
    func LoginButtonView(title: String, action: @escaping () -> Void) -> some View {
        AuthButton(title: title, action: action)
    }
}

// MARK: - Methods Extension
extension LoginView {
    private func loginButtonTapped() {
        performLoginAction {
            try await viewModel.login(email: emailInput, password: passwordInput)
        }
    }
    
    private func googleLoginButtonTapped() {
        performLoginAction {
            try await viewModel.loginWithGoogle()
        }
    }
    
    private func performLoginAction(action: @escaping () async throws -> Void) {
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                try await action()
                await MainActor.run {
                    coordinator.showTabBarAsRoot()
                }
            } catch {
                showError(error: error)
            }
        }
    }
}



// MARK: - Preview
#Preview {
    LoginView(coordinator: FlowCoordinator(navigationController: UINavigationController()))
}
