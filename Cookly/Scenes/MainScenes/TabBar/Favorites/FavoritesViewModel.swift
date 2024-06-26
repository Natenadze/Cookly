//
//  FavoritesViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 26.03.24.
//

import Foundation

final class FavoritesViewModel {
    
    // MARK: - Properties
    @Injected(\.recipeStorage) var recipeStorage: RecipeStorage
    weak var coordinator: Coordinator?
    
    
    var savedRecipes: [Recipe] {
        recipeStorage.fetchSavedRecipes()
    }
    
    // MARK: - LifeCycle
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
 
    func handleIsSaveButtonTapped(recipe: Recipe) {
        recipeStorage.toggleSavedRecipe(with: recipe)
    }
    
}
