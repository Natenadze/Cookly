//
//  InjectedDependencies.swift
//  Cookly
//
//  Created by Davit Natenadze on 22.01.24.
//

import Foundation

// MARK: - Injected Dependencies
struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProviding = ApiManager()
}

struct AuthServiceKey: InjectionKey {
    static var currentValue: AuthProviding = AuthService()
}

struct UserServiceKey: InjectionKey {
    static var currentValue: UserServiceProviding = UserService()
}

struct RecipeServiceKey: InjectionKey {
    static var currentValue: RecipeProviding = RecipeService()
}

struct AuthViewModelKey: InjectionKey {
    static var currentValue: AuthenticationViewModel = AuthenticationViewModel()
}

//TODO: - create viewModels in coordinator and use init dependency injection
struct MainViewModelKey: InjectionKey {
    static var currentValue: MainViewModel = MainViewModel()
}

struct ProfileViewModelKey: InjectionKey {
    static var currentValue: ProfileViewModel = ProfileViewModel()
}

struct SupabaseClientKey: InjectionKey {
    static var currentValue = SupaClient.supabase
}




