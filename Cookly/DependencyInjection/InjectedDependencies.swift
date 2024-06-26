//
//  InjectedDependencies.swift
//  Cookly
//
//  Created by Davit Natenadze on 22.01.24.
//

import Foundation
import Supabase

// MARK: - Injected Dependencies

struct AuthServiceKey: InjectionKey {
    static var currentValue: AuthProviding = AuthService()
}

struct UserServiceKey: InjectionKey {
    static var currentValue: UserServiceProviding = UserService()
}

struct RecipeServiceKey: InjectionKey {
    static var currentValue: RecipeProviding = RecipeService()
}

struct SupabaseClientKey: InjectionKey {
    static var currentValue = SupabaseClient(
        supabaseURL: URL(string: APIConstants.supaUrl)!,
        supabaseKey: APIConstants.supaKey
    )
}

struct AuthManagerKey: InjectionKey {
    static var currentValue: AuthCredentialsManager = AuthCredentialsManager()
}

struct RecipeStorageKey: InjectionKey {
    static var currentValue: RecipeStorage = RecipeStorage()
}




