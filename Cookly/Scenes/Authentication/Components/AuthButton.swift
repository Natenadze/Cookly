//
//  AuthButton.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import SwiftUI

struct AuthButton: View {
    
    // MARK: - Properties
    let title: String
    let action: () -> Void
    var isActive: Bool
    
    // MARK: - Body
    var body: some View {
        Button(title) {
            action()
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .font(.system(size: 16, weight: .bold))
        .background(isActive ? .blue : .gray)
        .foregroundColor(isActive ? .white : .black)
        .cornerRadius(8)
        .padding(.bottom, 80)
        .disabled(!isActive)
    }
}
