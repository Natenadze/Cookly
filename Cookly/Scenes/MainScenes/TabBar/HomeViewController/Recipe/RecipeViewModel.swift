//
//  RecipeViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 31.03.24.
//

import Foundation


final class RecipeViewModel {
    
    // MARK: - Properties
    @Injected(\.recipeStorage) var recipeStorage: RecipeStorage
        
    
    var savedRecipes: [Recipe] {
        recipeStorage.fetchSavedRecipes()
    }
    
    
    // MARK: - Methods
 
    func handleIsSaveButtonTapped(recipe: Recipe) {
        recipeStorage.toggleSavedRecipe(with: recipe)
    }
    
}
