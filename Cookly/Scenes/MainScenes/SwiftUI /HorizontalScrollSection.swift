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
    var recipes: [Recipe]
    var delegate: ScrollViewDelegate?
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(recipes, id: \.name) { recipe in
                        VStack(alignment: .leading) {
                            Image("test")
                                .resizable()
                                .frame(width: 140, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(4)
                                .onTapGesture {
                                    delegate?.navigateToRecipeViewController(recipe: recipe)
                                }
                            
                            Text(recipe.name)
                                .padding(.trailing)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .frame(width: 140, alignment: .leading)
                        }
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
    ScrollableSection(title: "Recent Recipes", recipes: recipesArray)
}
#endif
