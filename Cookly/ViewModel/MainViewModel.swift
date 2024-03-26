//
//  MainViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 09.02.24.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Properties
    @Injected(\.recipeProvider) var recipeProvider: RecipeProviding
    @Injected(\.recipeStorage) var recipeStorage: RecipeStorage
    
    var prompt = Prompt()
    
    var allRecipes = [Recipe]() {
        didSet {
            recipeStorage.saveRecipes(recipes: allRecipes, key: "allRecipes")
        }
    }
    
    var savedRecipes = [Recipe]() {
        didSet {
            recipeStorage.saveRecipes(recipes: savedRecipes, key: "savedRecipes")
        }
    }
    
    // MARK: - Init
    init() {
        allRecipes = recipeStorage.loadAllRecipes()
        savedRecipes = recipeStorage.loadSavedRecipes()
    }
    
    // MARK: - Methods
    func clearPrompt() {
        prompt = Prompt()
    }
    
    //TODO: - create enum for meal types
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
    
    //TODO: - create enum for difficulties
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
            if let result = await recipeProvider.generateRecipe(prompt: prompt) {
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
