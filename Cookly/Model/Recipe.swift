//
//  Recipe.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import Foundation

//TODO: - add id to recipe model
struct Recipe: Codable {
    let name: String
    let image: String
    let ingredients: [Ingredient]
    let instructions: [String]
    let diets: [Diet]
    let time: Int
    let servings: Int
    let mealType: MealType
    var isSaved: Bool! = false
}

