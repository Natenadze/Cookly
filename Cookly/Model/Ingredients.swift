//
//  Ingredients.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.01.24.
//

import Foundation


struct Recipe: Decodable {
    let name: String
    let image: String
    let ingredients: [Ingredient]
    let instructions: [String]
    let diets: [Diet]
    let time: Int
    let servings: Int
    let mealType: MealType
}

struct Ingredient: Decodable {
    let name: String
    let quantity: String
    let emoji: String
}


enum MealType: String, Decodable {
    case Breakfast = "breakfast"
    case Lunch = "lunch"
    case Dinner = "dinner"
    case Snack = "snack"
}


enum Diet: Decodable {
    case Vegetarian
    case Vegan
    case LactoseFree
    case GlutenFree
    case Healthy
    case HighProtein
    case LowCarb
    case unknown(value: String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "Vegetarian": self = .Vegetarian
        case "Vegan": self = .Vegan
        case "LactoseFree": self = .LactoseFree
        case "GlutenFree": self = .GlutenFree
        case "Healthy": self = .Healthy
        case "HighProtein": self = .HighProtein
        case "LowCarb": self = .LowCarb
        default:
            self = .unknown(value: status ?? "unknown")
        }
    }
}






