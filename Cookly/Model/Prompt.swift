//
//  Prompt.swift
//  Cookly
//
//  Created by Davit Natenadze on 05.02.24.
//

import Foundation

struct Prompt: Encodable {
    let mealType: MealType
    let diet: [Diet]
    let time: Int
    let ingredients: [String]
    let extendRecipe: Bool
}
