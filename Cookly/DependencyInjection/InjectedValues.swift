//
//  InjectedValues.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation
import Supabase

struct InjectedValues {
    
    /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
    private static var current = InjectedValues()
    
    /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    /// A static subscript accessor for updating and references dependencies directly.
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

// MARK: - Extension
extension InjectedValues {
    
    var authService: AuthProviding {
        get { Self[AuthServiceKey.self] }
        set { Self[AuthServiceKey.self] = newValue }
    }
    
    var userService: UserServiceProviding {
        get { Self[UserServiceKey.self] }
        set { Self[UserServiceKey.self] = newValue }
    }
    
    var recipeProvider: RecipeProviding {
        get { Self[RecipeServiceKey.self] }
        set { Self[RecipeServiceKey.self] = newValue }
    }
    
    var authViewModel: AuthenticationViewModel {
        get { Self[AuthViewModelKey.self] }
        set { Self[AuthViewModelKey.self] = newValue }
    } 
    
    var mainViewModel: MainViewModel {
        get { Self[MainViewModelKey.self] }
        set { Self[MainViewModelKey.self] = newValue }
    }   
    
    var profileViewModel: ProfileViewModel {
        get { Self[ProfileViewModelKey.self] }
        set { Self[ProfileViewModelKey.self] = newValue }
    }  
    
    var supaClient: SupabaseClient {
        get { Self[SupabaseClientKey.self] }
        set { Self[SupabaseClientKey.self] = newValue }
    }
}
