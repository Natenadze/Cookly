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
        if let index = savedRecipes.firstIndex(where: { $0.name == recipe.name }) {
            savedRecipes.remove(at: index)
        } else {
            savedRecipes.append(recipe)
        }
    }

    
    
    func generateRecipe(prompt: Prompt, completion: @escaping (Recipe?) -> Void) {
        allRecipes.append(rcp)
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
