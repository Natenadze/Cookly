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

struct AuthViewModelKey: InjectionKey {
    static var currentValue: AuthenticationViewModel = AuthenticationViewModel()
}

struct MainViewModelKey: InjectionKey {
    static var currentValue: MainViewModel = MainViewModel()
}
