//
//  MainViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 09.02.24.
//

import Foundation

//TODO: - remove MainViewModel
final class MainViewModel {
    
    // MARK: - Properties
    @Injected(\.recipeProvider) var recipeProvider: RecipeProviding
    weak var coordinator: Coordinator?
    
    let storage = RecipeStorage()
    var prompt = Prompt()
    
    var allRecipes = [Recipe]() {
        didSet {
            storage.saveRecipes(recipes: allRecipes, key: "allRecipes")
        }
    }
    var savedRecipes = [Recipe]() {
        didSet {
            storage.saveRecipes(recipes: savedRecipes, key: "savedRecipes")
        }
    }
    
    // MARK: - Init
    init() {
        allRecipes = storage.loadAllRecipes()
        savedRecipes = storage.loadSavedRecipes()
    }
    
    // MARK: - Methods
    func clearPrompt() {
        prompt = Prompt()
    }
    
    
    func updateMealType(_ type: MealType) {
        switch type {
        case .breakfast:
            prompt.mealType = .breakfast
        case .lunch:
            prompt.mealType = .lunch
        default:
            prompt.mealType = .dinner
        }
    }
    
    
    func updateDifficulty(_ difficulty: DifficultyLevel) {
        switch difficulty {
        case .easy:
            prompt.time = 20
        case .medium:
            prompt.time = 40
        default:
            prompt.time = 60
        }
    }
    
    func removeIngredientFromPromptAtIndex(_ index: Int) {
        prompt.ingredients.remove(at: index)
    }
    
    func toggleSavedRecipe(with recipe: Recipe) {
        if let index = savedRecipes.firstIndex(where: { $0.name == recipe.name }) {
            savedRecipes.remove(at: index)
        } else {
            savedRecipes.append(recipe)
        }
    }
    
    func updateAllRecipes(with recipe: Recipe) {
        allRecipes.insert(recipe, at: 0)
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
