//
//  ApiManager.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation
import Supabase
import AuthenticationServices

enum AuthError: Error {
    case invalidEmail
    case invalidPassword
    case invalidCredentials
    case userNotFound
    case networkError
    case serverError
    case unknownError
}


final class ApiManager: NSObject, NetworkProviding {
    
    // MARK: - Properties
    private let supabase = SupabaseClient(
        supabaseURL: APIConstants.supaUrl,
        supabaseKey: APIConstants.supaKey
    )
    

    
    
    // MARK: - Methods
    func checkIfUserIsSignedIn() async -> Bool  {
        if let _ = try? await supabase.auth.user() {
            return true
        }
        return false
    }
    
    func generateRecipe(prompt: Prompt) async -> Recipe? {
        var result: Recipe? = nil
        
        do {
            result = try await supabase.functions
                .invoke(
                    "generate-recipe",
                    options: FunctionInvokeOptions(
                        body: prompt
                    )
                )
        } catch FunctionsError.httpError(let code, let data) {
            print("Function returned code \(code) with response \(String(data: data, encoding: .utf8) ?? "")")
        } catch FunctionsError.relayError {
            print("Relay error")
        } catch {
            print("Other error: \(error.localizedDescription)")
        }
        
        return result
    }
    
    
    func login(email: String, password: String) async throws {
        do {
            try await supabase.auth.signIn(
                email: email,
                password: password
            )
            print("success login")
        } catch {
            //TODO: - Handle error
//            throw AuthError.invalidCredentials
            throw AuthError.networkError
        }
    }
    
    
    func loginWithGoogle() async throws {
        let url = try await supabase.auth.getOAuthSignInURL(provider: .google)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "cookly") { callbackURL, error in
                if let error {
                    print(error.localizedDescription)
                    continuation.resume(throwing: AuthError.serverError)
                    return
                }
                
                guard let callbackURL else {
                    continuation.resume(throwing: AuthError.unknownError)
                    return
                }
                
                Task {
                    do {
                        _ = try await self.supabase.auth.session(from: callbackURL)
                        continuation.resume(returning: ())
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
            session.presentationContextProvider = self
            session.start()
        }
    }
    
    func register(email: String, password: String) async throws {
        do {
            try await supabase.auth.signUp(
                email: email,
                password: password
            )
            print("success registration")
        } catch {
            //TODO: - Handle error
            print("registration error")
            throw AuthError.unknownError
        }
    }
    
    
    func signOut() async {
        do {
            try await supabase.auth.signOut()
            print("successful logout")
        } catch {
            print("fail logout")
        }
    }
}

// MARK: - Extension
extension ApiManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        var anchor: ASPresentationAnchor?
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                anchor = window
            } else {
                fatalError("No window available for presentation.")
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        return anchor!
    }
}
