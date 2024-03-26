//
//  InjectedDependencies.swift
//  Cookly
//
//  Created by Davit Natenadze on 22.01.24.
//

import Foundation

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


//TODO: - create viewModels in coordinator and use init dependency injection
struct MainViewModelKey: InjectionKey {
    static var currentValue: MainViewModel = MainViewModel()
}

struct SupabaseClientKey: InjectionKey {
    static var currentValue = SupaClient.supabase
}

struct AuthManagerKey: InjectionKey {
    static var currentValue: AuthCredentialsManager = AuthCredentialsManager()
}

struct RecipeStorageKey: InjectionKey {
    static var currentValue: RecipeStorage = RecipeStorage()
}




