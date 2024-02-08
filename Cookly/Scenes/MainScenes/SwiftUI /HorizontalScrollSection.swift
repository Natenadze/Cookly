//
//  HorizontalScrollSection.swift
//  Cookly
//
//  Created by Davit Natenadze on 23.01.24.
//


import SwiftUI

struct ScrollableSection: View {
    
    // MARK: - Properties
    let title: String
    let images: [UIImage]
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.title)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: - Preview

#if DEBUG
#Preview {
    ScrollableSection(title: "Recent Recipes", images: [
        UIImage(named: "dish")!,
        UIImage(named: "kha")!,
        UIImage(named: "dish")!,
        UIImage(named: "dish")!,
        UIImage(named: "dish")!,
        UIImage(named: "kha")!,
        UIImage(named: "kha")!,
    ])
}
#endif
