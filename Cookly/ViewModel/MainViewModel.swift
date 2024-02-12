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
    var prompt = Prompt()
    
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
    
    func updateMealType(text: String) {
        switch text {
        case "Breakfast":
            prompt.mealType = .Breakfast
        case "Lunch":
            prompt.mealType = .Lunch
        default:
            prompt.mealType = .Dinner
        }
    }   
    
    func updateDifficulty(text: String) {
        switch text {
        case "Easy":
            prompt.time = 20
        case "Medium":
            prompt.time = 40
        default:
            prompt.time = 60
        }
    }
    
    func removeIngredientFromPromptAtIndex(_ index: Int) {
        prompt.ingredients.remove(at: index)
    }
    
    
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
    
    func generateRecipe(completion: @escaping (Recipe?) -> Void) {
        Task {
            if let result = await apiManager.generateRecipe(prompt: prompt) {
                await MainActor.run {
                    self.updateAllRecipes(with: result)
                    completion(result)
                }
            } else {
                await MainActor.run {
                    completion(nil)
                }
            }
        }
    }
}
