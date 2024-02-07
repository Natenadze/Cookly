//
//  ApiManager.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation
import Supabase
import AuthenticationServices


class ApiManager: NSObject, NetworkProviding {
    
    // MARK: - Properties
    private let supabase = SupabaseClient(
        supabaseURL: APIConstants.supaUrl,
        supabaseKey: APIConstants.supaKey
    )
    
    // MARK: - Methods
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
    
    
    func login(email: String, password: String) async {
        do {
            try await supabase.auth.signIn(
                email: email,
                password: password
            )
            print("success login")
        } catch {
            //TODO: - Handle error
            print("login error")
        }
    }
    
    
    func loginWithGoogle() async {
        guard let url = try? await supabase.auth.getOAuthSignInURL(provider: .google) else { return }
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "cookly") { url, error in
            guard let url else {
                print("no url line 50")
                return
            }
            
            Task {
                try await self.supabase.auth.session(from: url)
                //TODO: - handle success
                print("success google")
            }
        }
        
        session.presentationContextProvider = self
        session.start()
    }
    
    func register(email: String, password: String) async {
        do {
            try await supabase.auth.signUp(
                email: email,
                password: password
            )
            print("success registration")
        } catch {
            //TODO: - Handle error
            print("registration error")
        }
    }
    
    
    func signOut() async {
        try? await supabase.auth.signOut()
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
