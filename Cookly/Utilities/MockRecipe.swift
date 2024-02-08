//
//  MockRecipe.swift
//  Cookly
//
//  Created by Davit Natenadze on 06.02.24.
//

import Foundation

#if DEBUG
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

let rcp1 = Recipe(
    name: "Classic Margherita Pizza",
    image: "pizza_image",
    ingredients: [
        Ingredient(name: "Pizza Dough", quantity: "1 ball", emoji: "🍕"),
        Ingredient(name: "Tomato Sauce", quantity: "1/2 cup", emoji: "🍅"),
        Ingredient(name: "Mozzarella Cheese", quantity: "1 cup", emoji: "🧀"),
        Ingredient(name: "Fresh Basil", quantity: "to taste", emoji: "🌿"),
        Ingredient(name: "Olive Oil", quantity: "1 tbsp", emoji: "🫒")
    ],
    instructions: [
        "Preheat your oven to 475°F (245°C).",
        "Roll out the pizza dough on a floured surface.",
        "Spread the tomato sauce evenly over the dough.",
        "Sprinkle mozzarella cheese on top.",
        "Add fresh basil leaves as desired.",
        "Drizzle olive oil over the pizza.",
        "Bake for 10-12 minutes or until the crust is golden brown.",
        "Slice and serve hot!"
    ],
    diets: [.Vegetarian],
    time: 45,
    servings: 4,
    mealType: .Lunch
)

let rcp2 = Recipe(
    name: "Grilled Lemon Herb Chicken",
    image: "chicken_image",
    ingredients: [
        Ingredient(name: "Chicken Breasts", quantity: "4", emoji: "🍗"),
        Ingredient(name: "Lemon", quantity: "1", emoji: "🍋"),
        Ingredient(name: "Garlic", quantity: "3 cloves", emoji: "🧄"),
        Ingredient(name: "Fresh Herbs (Rosemary, Thyme, Parsley)", quantity: "to taste", emoji: "🌿"),
        Ingredient(name: "Salt and Pepper", quantity: "to taste", emoji: "🧂")
    ],
    instructions: [
        "Preheat your grill to medium-high heat.",
        "In a small bowl, mix together lemon juice, minced garlic, chopped herbs, salt, and pepper.",
        "Place chicken breasts in a shallow dish and pour the marinade over them. Let marinate for at least 30 minutes.",
        "Grill the chicken for 6-7 minutes on each side or until cooked through.",
        "Remove from grill and let rest for a few minutes before serving.",
        "Serve with your favorite sides and enjoy!"
    ],
    diets: [.LowCarb],
    time: 35,
    servings: 4,
    mealType: .Dinner
)

let rcp3 = Recipe(
    name: "Quinoa Salad with Avocado and Chickpeas",
    image: "salad_image",
    ingredients: [
        Ingredient(name: "Quinoa", quantity: "1 cup", emoji: "🍚"),
        Ingredient(name: "Avocado", quantity: "1", emoji: "🥑"),
        Ingredient(name: "Chickpeas", quantity: "1 can", emoji: "🥫"),
        Ingredient(name: "Cucumber", quantity: "1/2", emoji: "🥒"),
        Ingredient(name: "Cherry Tomatoes", quantity: "1 cup", emoji: "🍅"),
        Ingredient(name: "Lemon Juice", quantity: "2 tbsp", emoji: "🍋")
    ],
    instructions: [
        "Rinse quinoa under cold water and cook according to package instructions.",
        "In a large bowl, combine cooked quinoa, diced avocado, drained and rinsed chickpeas, chopped cucumber, and halved cherry tomatoes.",
        "Drizzle lemon juice over the salad and toss gently to combine.",
        "Season with salt and pepper to taste.",
        "Chill in the refrigerator for at least 30 minutes before serving.",
        "Serve as a light and refreshing meal!"
    ],
    diets: [.Vegetarian, .Vegan, .GlutenFree],
    time: 25,
    servings: 4,
    mealType: .Lunch
)

let rcp4 = Recipe(
    name: "Spaghetti Aglio e Olio",
    image: "spaghetti_image",
    ingredients: [
        Ingredient(name: "Spaghetti", quantity: "12 oz", emoji: "🍝"),
        Ingredient(name: "Garlic", quantity: "4 cloves", emoji: "🧄"),
        Ingredient(name: "Extra Virgin Olive Oil", quantity: "1/4 cup", emoji: "🫒"),
        Ingredient(name: "Red Pepper Flakes", quantity: "1/2 tsp", emoji: "🌶️"),
        Ingredient(name: "Fresh Parsley", quantity: "1/4 cup", emoji: "🌿")
    ],
    instructions: [
        "Cook spaghetti according to package instructions until al dente. Drain and set aside.",
        "In a large skillet, heat olive oil over medium heat. Add minced garlic and red pepper flakes. Cook until garlic is golden but not browned.",
        "Add cooked spaghetti to the skillet and toss to coat evenly with the garlic-infused oil.",
        "Season with salt and pepper to taste. Add chopped parsley and toss again.",
        "Serve hot, garnished with additional parsley if desired.",
        "Enjoy this simple yet flavorful pasta dish!"
    ],
    diets: [.Vegetarian],
    time: 20,
    servings: 4,
    mealType: .Dinner
)

let rcp5 = Recipe(
    name: "Berry Spinach Smoothie",
    image: "smoothie_image",
    ingredients: [
        Ingredient(name: "Spinach", quantity: "2 cups", emoji: "🥬"),
        Ingredient(name: "Mixed Berries (Strawberries, Blueberries, Raspberries)", quantity: "1 cup", emoji: "🍓"),
        Ingredient(name: "Banana", quantity: "1", emoji: "🍌"),
        Ingredient(name: "Greek Yogurt", quantity: "1/2 cup", emoji: "🥛"),
        Ingredient(name: "Almond Milk", quantity: "1 cup", emoji: "🥛")
    ],
    instructions: [
        "Combine spinach, mixed berries, banana, Greek yogurt, and almond milk in a blender.",
        "Blend until smooth and creamy.",
        "If the smoothie is too thick, add more almond milk until desired consistency is reached.",
        "Pour into glasses and serve immediately.",
        "Enjoy this nutritious and delicious smoothie as a refreshing breakfast or snack!"
    ],
    diets: [.Vegetarian],
    time: 10,
    servings: 2,
    mealType: .Breakfast
)

let rcp6 = Recipe(
    name: "Vegetable Stir-Fry with Tofu",
    image: "stirfry_image",
    ingredients: [
        Ingredient(name: "Tofu", quantity: "1 block", emoji: "🥢"),
        Ingredient(name: "Broccoli", quantity: "2 cups", emoji: "🥦"),
        Ingredient(name: "Bell Pepper", quantity: "1", emoji: "🫑"),
        Ingredient(name: "Carrots", quantity: "2", emoji: "🥕"),
        Ingredient(name: "Soy Sauce", quantity: "2 tbsp", emoji: "🥄"),
        Ingredient(name: "Sesame Oil", quantity: "1 tbsp", emoji: "🥄")
    ],
    instructions: [
        "Press tofu to remove excess water, then cut into cubes.",
        "Heat sesame oil in a large skillet or wok over medium-high heat.",
        "Add tofu cubes and cook until golden brown on all sides. Remove from skillet and set aside.",
        "In the same skillet, add more oil if needed, then add chopped broccoli, sliced bell pepper, and julienned carrots.",
        "Stir-fry vegetables until tender-crisp.",
        "Return tofu to the skillet, pour soy sauce over the mixture, and toss to combine.",
        "Cook for another minute, then remove from heat.",
        "Serve hot over cooked rice or noodles.",
        "Enjoy this flavorful and nutritious stir-fry!"
    ],
    diets: [.Vegetarian, .Vegan],
    time: 25,
    servings: 4,
    mealType: .Dinner
)

// Array containing all the recipes
let recipesArray = [rcp, rcp1, rcp2, rcp3, rcp4, rcp5, rcp6]
#endif
