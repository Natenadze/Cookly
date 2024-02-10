//
//  MainViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 09.02.24.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Properties
    @Injected(\.networkProvider) var apiManager: NetworkProviding
    
    var allRecipes = [Recipe]()
    var savedRecipes = [Recipe]()
    
    // MARK: - Methods
    
    func updateAllRecipes(with recipe: Recipe) {
        allRecipes.append(recipe)
    } 
    
    func toggleSavedRecipe(with recipe: Recipe) {
        // Find the index of the recipe with the same name
        if let index = savedRecipes.firstIndex(where: { $0.name == recipe.name }) {
            // If found, remove the recipe from savedRecipes
            savedRecipes.remove(at: index)
        } else {
            // If not found, add the recipe to savedRecipes
            savedRecipes.append(recipe)
        }
    }

    
    
    func generateRecipe(prompt: Prompt, completion: @escaping (Recipe?) -> Void) {
        allRecipes = recipesArray
        completion(rcp)
//        Task {
//            if let result = await apiManager.generateRecipe(prompt: prompt) {
//                await MainActor.run {
//                    self.updateAllRecipes(with: result)
//                    completion(result)
//                }
//            } else {
//                await MainActor.run {
//                    completion(nil)
//                }
//            }
//        }
        
    }
}
