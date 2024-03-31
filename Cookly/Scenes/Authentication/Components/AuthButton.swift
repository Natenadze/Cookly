//
//  AuthButton.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import SwiftUI

struct AuthButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .font(.system(size: 16, weight: .bold))
            .background(.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}


