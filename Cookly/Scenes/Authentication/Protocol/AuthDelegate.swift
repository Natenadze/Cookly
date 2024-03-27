//
//  AuthDelegate.swift
//  Cookly
//
//  Created by Davit Natenadze on 22.03.24.
//

import Foundation

protocol AuthDelegate: AnyObject {
    func loginViewDidTapLogin()
    func registrationViewDidTapRegister()
    func loginViewDidTapDontHaveAnAccount()
}
