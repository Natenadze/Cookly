//
//  InjectionKey.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation

public protocol InjectionKey {
    associatedtype Value
    static var currentValue: Value { get set }
}

