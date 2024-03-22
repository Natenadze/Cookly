//
//  LocalState.swift
//  Cookly
//
//  Created by Davit Natenadze on 22.03.24.
//

import Foundation

final class LocalState {
    
    private enum Keys: String {
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
}

