//
//  RecipeStorage.swift
//  Cookly
//
//  Created by Davit Natenadze on 26.03.24.
//

import Foundation


final class RecipeStorage {
    
    
    private var recentRecipes: [Recipe] = []
    private var savedRecipes: [Recipe] = []
    
    init() {
        savedRecipes = loadSavedRecipes()
        recentRecipes = loadRecentRecipes()
    }
    
    
    func fetchSavedRecipes() -> [Recipe] {
        savedRecipes
    }  
    
    func fetchRecentRecipes() -> [Recipe] {
        recentRecipes
    } 
    
    func updateRecentRecipes(with recipe: Recipe)  {
        recentRecipes.insert(recipe, at: 0)
        saveRecipes(.recent)
    }
    
    func toggleSavedRecipe(with recipe: Recipe) {
        if let index = savedRecipes.firstIndex(where: { $0.id == recipe.id }) {
            savedRecipes.remove(at: index)
        } else {
            savedRecipes.insert(recipe, at: 0)
        }
        saveRecipes(.favorite)
    }
    
    
    func saveRecipes(_ type: RecipeStorageType) {
        let encoder = JSONEncoder()
        
        switch type {
        case .recent:
            if let encoded = try? encoder.encode(recentRecipes) {
                UserDefaults.standard.set(encoded, forKey: "recentRecipes")
            }
        case .favorite:
            if let encoded = try? encoder.encode(savedRecipes) {
                UserDefaults.standard.set(encoded, forKey: "savedRecipes")
            }
        }
        
    }
    
    
    func loadRecentRecipes() -> [Recipe] {
        let decoder = JSONDecoder()
        //TODO: - use user default keys instead of strings
        if let allRecipesData = UserDefaults.standard.data(forKey: "allRecipes"),
           let recipes = try? decoder.decode([Recipe].self, from: allRecipesData) {
            return recipes
        }
        return []
    }
    
    func loadSavedRecipes() -> [Recipe] {
        let decoder = JSONDecoder()
        
        if let savedRecipesData = UserDefaults.standard.data(forKey: "savedRecipes"),
           let recipes = try? decoder.decode([Recipe].self, from: savedRecipesData) {
            return recipes
        }
        return []
    }
}

