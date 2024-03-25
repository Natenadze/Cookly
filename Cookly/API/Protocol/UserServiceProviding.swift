//
//  UserServiceProviding.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation

enum AuthError: Error {
    case invalidEmail
    case invalidPassword
    case invalidCredentials
    case networkError
    case serverError
    case unknownError
}

protocol UserServiceProviding {
    func checkIfUserIsSignedIn() async -> Bool
    func signOut() async throws
    func deleteUser() async throws
}
