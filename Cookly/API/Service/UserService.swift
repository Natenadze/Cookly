//
//  UserService.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation
import Supabase


final class UserService: UserServiceProviding {
    
    // MARK: - Properties
    @Injected(\.supaClient) var supaClient: SupabaseClient
    
    // MARK: - Methods
    func checkIfUserIsSignedIn() async -> Bool  {
        if let _ = try? await supaClient.auth.user() {
            return true
        }
        return false
    }
    
    func signOut() async throws {
        do {
            try await supaClient.auth.signOut()
        } catch {
            throw AuthError.serverError
        }
    }
    
    func deleteUser() async throws {
        do {
            try await supaClient.functions.invoke("delete-user")
        } catch FunctionsError.httpError(let code, let data) {
            print("Function returned code \(code) with response \(String(data: data, encoding: .utf8) ?? "")")
        } catch FunctionsError.relayError {
            print("Relay error")
        } catch {
            print("Other error: \(error.localizedDescription)")
        }
    }
}
