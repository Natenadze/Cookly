//
//  UserServiceProviding.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation

protocol UserServiceProviding {
    func checkIfUserIsSignedIn() async -> Bool
    func signOut() async throws
    func deleteUser() async throws
}
