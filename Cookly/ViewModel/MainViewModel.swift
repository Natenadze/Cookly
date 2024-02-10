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
    
    var allRecipes = [Recipe]() {
        didSet {
            saveRecipes(recipes: allRecipes, key: "allRecipes")
        }
    }
    var savedRecipes = [Recipe]() {
        didSet {
            saveRecipes(recipes: savedRecipes, key: "savedRecipes")
        }
    }
    
    // MARK: - Init
    init() {
        loadRecipes()
    }
    
    // MARK: - Methods
    private func saveRecipes(recipes: [Recipe], key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func loadRecipes() {
        let decoder = JSONDecoder()
        
        if let allRecipesData = UserDefaults.standard.data(forKey: "allRecipes"),
           let recipes = try? decoder.decode([Recipe].self, from: allRecipesData) {
            allRecipes = recipes
        }
        
        if let savedRecipesData = UserDefaults.standard.data(forKey: "savedRecipes"),
           let recipes = try? decoder.decode([Recipe].self, from: savedRecipesData) {
            savedRecipes = recipes
        }
    }
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
