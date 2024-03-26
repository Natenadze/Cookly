//
//  AuthError.swift
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
