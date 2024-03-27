//
//  AuthButton.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import SwiftUI

//TODO: - Use buttonStyle instead
struct AuthButton: View {
    
    // MARK: - Properties
    let title: String
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .font(.system(size: 16, weight: .bold))
                .background(.orange)
                .foregroundColor(.white)
                .cornerRadius(8)
        })
    }
}


#if DEBUG
#Preview {
    AuthButton(title: "Login", action: {
        print("login button tapped")
    })
}
#endif
