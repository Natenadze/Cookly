//
//  Prompt.swift
//  Cookly
//
//  Created by Davit Natenadze on 05.02.24.
//

import Foundation

struct Prompt: Encodable {
    
    // MARK: - Properties
    var ingredients: [String]
    var mealType: MealType
    var time: Int
    var diet: [Diet]
    var extendRecipe: Bool
    
    // MARK: - Init
    init(
        ingredients: [String] = [],
        mealType: MealType = .Lunch,
        time: Int = 40,
        diet: [Diet] = [],
        extendRecipe: Bool = false
    ) {
        self.ingredients = ingredients
        self.mealType = mealType
        self.time = time
        self.diet = diet
        self.extendRecipe = extendRecipe
    }
}
