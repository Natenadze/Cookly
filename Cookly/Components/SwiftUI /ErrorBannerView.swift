//
//  ErrorBannerView.swift
//  Cookly
//
//  Created by Davit Natenadze on 11.02.24.
//

import SwiftUI

struct ErrorBannerView: View {
    
    // MARK: - Properties
    @Binding var isVisible: Bool
    let message: String
    
// MARK: - Body
    var body: some View {
        Text(message)
            .padding()
            .font(.headline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .systemGray5))
            .cornerRadius(5)
            .offset(y: isVisible ? -50 : -170)
            .animation(.easeInOut(duration: 0.5), value: isVisible)
            .onChange(of: isVisible) { _, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.isVisible = false
                    }
                }
            }
    }
}
