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
    
    var savedRecipes = [Recipe]() {
        didSet {
            recipeStorage.saveRecipes(recipes: savedRecipes, key: "savedRecipes")
        }
    }
    
    // MARK: - LifeCycle
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
        savedRecipes = recipeStorage.loadSavedRecipes()
    }
    
    // MARK: - Methods
    func toggleSavedRecipe(with recipe: Recipe) {
        if let index = savedRecipes.firstIndex(where: { $0.name == recipe.name }) {
            savedRecipes.remove(at: index)
        } else {
            savedRecipes.append(recipe)
        }
    }
    
}
