//
//  PromptViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 23.01.24.
//

import UIKit

//struct mod {
//    let recipe1 = Recipe(name: "Recipe 1",
//                         image: "image 1",
//                         ingredients: [
//                            .init(name: "Ingredient 1", quantity: "1", emoji: "emoji 1"),
//                            .init(name: "Ingredient 2", quantity: "2", emoji: "emoji 2")
//                         ],
//                         instructions: ["Step 1", "Step 2", "Step 3"],
//                         diets: [.GlutenFree, .Vegan],
//                         time: 30,
//                         servings: 2,
//                         mealType: .Dinner)
//
//    let recipe2 = Recipe(name: "Recipe 2",
//                         image: "image 2",
//                         ingredients: [
//                            .init(name: "Ingredient 3", quantity: "3", emoji: "emoji 3"),
//                            .init(name: "Ingredient 4", quantity: "4", emoji: "emoji 4")
//                         ],
//                         instructions: ["Step 1", "Step 2", "Step 3"],
//                         diets: [.Vegetarian, .Healthy],
//                         time: 45,
//                         servings: 4,
//                         mealType: .Lunch)
//    
//    // Continuing from the previous code...
//
//    let recipe3 = Recipe(name: "Recipe 3",
//                         image: "image 3",
//                         ingredients: [
//                            .init(name: "Ingredient 5", quantity: "5", emoji: "emoji 5"),
//                            .init(name: "Ingredient 6", quantity: "6", emoji: "emoji 6")
//                         ],
//                         instructions: ["Step 1", "Step 2", "Step 3"],
//                         diets: [.LowCarb, .HighProtein],
//                         time: 40,
//                         servings: 3,
//                         mealType: .Snack)
//
//    let recipe4 = Recipe(name: "Recipe 4",
//                         image: "image 4",
//                         ingredients: [
//                            .init(name: "Ingredient 7", quantity: "7", emoji: "emoji 7"),
//                            .init(name: "Ingredient 8", quantity: "8", emoji: "emoji 8")
//                         ],
//                         instructions: ["Step 1", "Step 2", "Step 3"],
//                         diets: [.Vegetarian, .Healthy],
//                         time: 50,
//                         servings: 5,
//                         mealType: .Breakfast)
//
//    let recipe5 = Recipe(name: "Recipe 5",
//                         image: "image 5",
//                         ingredients: [
//                            .init(name: "Ingredient 9", quantity: "9", emoji: "emoji 9"),
//                            .init(name: "Ingredient 10", quantity: "10", emoji: "emoji 10")
//                         ],
//                         instructions: ["Step 1", "Step 2", "Step 3"],
//                         diets: [.LactoseFree, .GlutenFree],
//                         time: 35,
//                         servings: 2,
//                         mealType: .Dinner)
//
//    lazy var recipeArray = [recipe1, recipe2, recipe3, recipe4, recipe5]
//
//}

class PromptViewController: UIViewController {
    
    let testJSON = Bundle.main.decode([Recipe].self, from: "test.json")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Under constr"
    }
}
