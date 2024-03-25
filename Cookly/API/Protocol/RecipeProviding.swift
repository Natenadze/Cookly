//
//  RecipeProviding.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation

protocol RecipeProviding {
    func generateRecipe(prompt: Prompt) async -> Recipe?
}
