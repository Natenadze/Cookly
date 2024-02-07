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
    let coordinator: Coordinator
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            textFieldStack
            dontHaveAnAccountButton
            LoginButtonView(title: "Login", action: LoginButtonTapped)
            orDivider
            googleSignInButton
                .padding(.top, 20)
        }
        .padding(.horizontal, 16)
        
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
                .padding(.top, 30)
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
            Task {
                try await viewModel.loginWithGoogle()
                //                    coordinator.showTabBarController()
                
            }
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
    func LoginButtonTapped() {
        //TODO: - add navigation logic
        coordinator.showTabBarController()
        Task {
            //            do {
            //                try viewModel.login(email: emailInput, password: passwordInput)
            //            } catch {
            //                print("Login Error")
            //            }
        }
    }
}


#Preview {
    LoginView(coordinator: FlowCoordinator(navigationController: UINavigationController()))
}
