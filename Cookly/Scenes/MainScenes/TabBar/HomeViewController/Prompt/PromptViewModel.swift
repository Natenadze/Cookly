//
//  PromptViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 09.02.24.
//

import Foundation

enum RecipeStorageType {
    case recent, favorite
}

final class PromptViewModel {
    
    // MARK: - Properties
    @Injected(\.recipeProvider) var recipeProvider: RecipeProviding
    @Injected(\.recipeStorage) var recipeStorage: RecipeStorage
    
    weak var coordinator: Coordinator?
    var prompt = Prompt()
    
    
    // MARK: - Init
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        
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
    
    
    func updateAllRecipes(with recipe: Recipe) {
        recipeStorage.updateRecentRecipes(with: recipe)
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
