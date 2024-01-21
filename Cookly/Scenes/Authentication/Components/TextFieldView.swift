//
//  TextFieldView.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import SwiftUI

struct AuthTextField: View {
    
    // MARK: - Properties
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black.opacity(0.6))
                }
            }
        }
        .padding(12)
        .autocorrectionDisabled()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(0.3))
        )
    }
}
