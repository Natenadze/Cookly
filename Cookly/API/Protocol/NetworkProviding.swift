//
//  NetworkProviding.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation

protocol NetworkProviding {
    func login(email: String, password: String) async throws
    func register(email: String, password: String) async throws
    func loginWithGoogle() async throws
    func generateRecipe(prompt: Prompt) async -> Recipe?
    func signOut() async
    func checkIfUserIsSignedIn() async -> Bool 
}
