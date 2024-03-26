//
//  Diet.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation

enum Diet: String, Codable, CaseIterable {
    case Vegetarian = "vegetarian"
    case Vegan = "vegan"
    case LactoseFree = "lactose-free"
    case GlutenFree = "gluten-free"
    case Healthy = "healthy"
    case HighProtein = "high-protein"
    case LowCarb = "low-carb"
}
