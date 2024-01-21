//
//  ApiManager.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation
import Supabase

struct ApiManager: NetworkProviding {
    
    // MARK: - Properties
    private let supabase = SupabaseClient(
        supabaseURL: APIConstants.supaUrl,
        supabaseKey: APIConstants.supaKey
    )
    
    // MARK: - Methods
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
}

