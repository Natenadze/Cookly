//
//  NetworkProvidingProtocol.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import Foundation

protocol NetworkProviding {
    func login(email: String, password: String) async
    func register(email: String, password: String) async
}
