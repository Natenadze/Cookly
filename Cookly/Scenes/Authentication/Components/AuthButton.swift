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
        Button(action: action, label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .font(.system(size: 16, weight: .bold))
                .background(isActive ? .orange : .orange.opacity(0.2))
                .foregroundColor(isActive ? .white : .gray)
                .cornerRadius(8)
                .disabled(!isActive)
        })
        
    }
}


#if DEBUG
#Preview {
    AuthButton(title: "Login", action: {
        print("login button tapped")
    }, isActive: true)
}
#endif
