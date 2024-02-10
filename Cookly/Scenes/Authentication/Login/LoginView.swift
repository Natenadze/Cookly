//
//  LoginView.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import SwiftUI

import SwiftUI

struct BackgroundViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> BackgroundView {
        BackgroundView()
    }
    
    func updateUIView(_ uiView: BackgroundView, context: Context) {
        
    }
}


struct LoginView: View {
    
    // MARK: - Properties
    @Injected(\.authViewModel) var viewModel: AuthenticationViewModel
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var isLoading: Bool = false
    
    let coordinator: Coordinator
    
    // MARK: - Body
    var body: some View {
        ZStack {
            BackgroundViewRepresentable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing:20) {
                textFieldStack
                dontHaveAnAccountButton
                LoginButtonView(title: "Login", action: loginButtonTapped)
                orDivider.padding(.top, 20)
                googleSignInButton.padding(.top, 20)
                    
            }
            .padding(.horizontal, 16)
            
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
        AuthButton(
            title: title,
            action: action,
            isActive: viewModel.isPasswordCriteriaMet(text: passwordInput)
        )
    }
}

// MARK: - Methods Extension
extension LoginView {
    //TODO: - refactor redundancy
    func loginButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await viewModel.login(email: emailInput, password: passwordInput)
                await MainActor.run {
                    coordinator.showTabBarAsRoot()
                }
            } catch {
                //TODO: - handle error
                print("Login Error")
            }
        }
    }
    
    func googleLoginButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await viewModel.loginWithGoogle()
                await MainActor.run {
                    coordinator.showTabBarAsRoot()
                }
            } catch {
                //TODO: - handle error
                print("Google Login Error")
            }
        }
    }
}


// MARK: - Preview
#Preview {
    LoginView(coordinator: FlowCoordinator(navigationController: UINavigationController()))
}
