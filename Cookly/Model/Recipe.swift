//
//  Recipe.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import Foundation


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
