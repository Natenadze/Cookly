//
//  RecipeStorage.swift
//  Cookly
//
//  Created by Davit Natenadze on 26.03.24.
//

import Foundation

final class RecipeStorage {
    
    func saveRecipes(recipes: [Recipe], key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    
    func loadAllRecipes() -> [Recipe] {
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
