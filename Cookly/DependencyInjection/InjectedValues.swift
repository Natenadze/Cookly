//
//  InjectedValues.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation

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
    var networkProvider: NetworkProviding {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
    
    var authViewModel: AuthenticationViewModel {
        get { Self[ViewModel.self] }
        set { Self[ViewModel.self] = newValue }
    }
}

// MARK: - Injected Dependencies
private struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProviding = ApiManager()
}

private struct ViewModel: InjectionKey {
    static var currentValue: AuthenticationViewModel = AuthenticationViewModel()
}



