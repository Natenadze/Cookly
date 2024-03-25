//
//  AuthService.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation
import AuthenticationServices
import Supabase


final class AuthService: NSObject, AuthProviding {
    
    // MARK: - Properties
    @Injected(\.supaClient) var supaClient: SupabaseClient
    
    // MARK: - Methods
    func login(email: String, password: String) async throws {
        do {
            try await supaClient.auth.signIn(
                email: email,
                password: password
            )
        } catch {
            throw AuthError.networkError
        }
    }
    
    
    func register(email: String, password: String) async throws {
        do {
            try await supaClient.auth.signUp(
                email: email,
                password: password
            )
            print("success registration")
        } catch {
            throw AuthError.serverError
        }
    }
    
    
    func loginWithGoogle() async throws {
        let url = try await supaClient.auth.getOAuthSignInURL(provider: .google)
        
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
                        _ = try await self.supaClient.auth.session(from: callbackURL)
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
}


extension AuthService: ASWebAuthenticationPresentationContextProviding {
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
