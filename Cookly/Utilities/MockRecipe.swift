//
//  MockRecipe.swift
//  Cookly
//
//  Created by Davit Natenadze on 06.02.24.
//

import Foundation

let rcp = Recipe(
    name: "Cheesy Onion Omelette",
    image: "test",
    ingredients: [
        Ingredient(name: "Egg", quantity: "2", emoji: "🥚"),
        Ingredient(name: "Cheese", quantity: "1/4 cup", emoji: "🧀"),
        Ingredient(name: "Oil", quantity: "1 tbsp", emoji: "🥄"),
        Ingredient(name: "Onion", quantity: "1/4 cup", emoji: "🧅"),
        Ingredient(name: "Spices", quantity: "to taste", emoji: "🌶️")
    ],
    instructions: [
        "Heat oil in a non-stick pan over medium heat.",
        "Add chopped onions and sauté until translucent.",
        "In a bowl, beat the eggs with spices.",
        "Pour the beaten eggs into the pan and let it cook for a minute.",
        "Sprinkle cheese on one half of the omelette.",
        "Fold the other half over the cheese and cook for another minute.",
        "Flip the omelette and cook for an additional minute or until cheese is melted.",
        "Serve hot and enjoy!"
    ],
    diets: [.Healthy, .GlutenFree],
    time: 30,
    servings: 2,
    mealType: .Breakfast
)
