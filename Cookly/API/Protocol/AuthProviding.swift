//
//  AuthProviding.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation

protocol AuthProviding {
    func login(email: String, password: String) async throws
    func register(email: String, password: String) async throws
    func loginWithGoogle() async throws
}
