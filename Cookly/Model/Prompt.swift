//
//  Prompt.swift
//  Cookly
//
//  Created by Davit Natenadze on 05.02.24.
//

import Foundation

struct Prompt: Encodable {
    var ingredients: [String]
    var mealType: MealType
    var time: Int
    var diet: [Diet]
    var extendRecipe: Bool
}
