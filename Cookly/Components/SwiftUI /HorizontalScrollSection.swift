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
            titleView
            
            if recipes.isEmpty {
                emptySectionView
            } else {
                recipesScrollView
            }
        }
    }
    
    // MARK: - Computed Properties
    private var titleView: some View {
        Text(title)
            .font(.title2)
            .foregroundStyle(.primary)
            .fontWeight(.semibold)
    }
    
    private var emptySectionView: some View {
        Text("This section is empty")
            .foregroundColor(.secondary)
            .padding(30)
            .frame(maxWidth: .infinity)
    }
    
    private var recipesScrollView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(recipes, id: \.name) { recipe in
                    recipeView(for: recipe)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func recipeView(for recipe: Recipe) -> some View {
        VStack(alignment: .leading) {
            Image(recipe.image)
                .resizable()
                .frame(width: 140, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(4)
                .onTapGesture {
                    delegate?.navigateToRecipeViewController(recipe: recipe)
                }
            
            Text(recipe.name)
                .padding(.trailing)
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .frame(width: 140, alignment: .leading)
        }
    }
    
}


// MARK: - Preview
#if DEBUG
#Preview {
    ScrollableSection(title: "Recent Recipes", recipes: [])
}
#endif
