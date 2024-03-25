//
//  Recipe.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import Foundation

//TODO: - better practice is to move models in separate files
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

struct Ingredient: Codable {
    let name: String
    let quantity: String
    let emoji: String
}

//TODO: - cases start with small letter (if possible :d)
enum MealType: String, Codable {
    case Breakfast = "breakfast"
    case Lunch = "lunch"
    case Dinner = "dinner"
}


enum Diet: String, Codable, CaseIterable {
    case Vegetarian = "vegetarian"
    case Vegan = "vegan"
    case LactoseFree = "lactose-free"
    case GlutenFree = "gluten-free"
    case Healthy = "healthy"
    case HighProtein = "high-protein"
    case LowCarb = "low-carb"
}
