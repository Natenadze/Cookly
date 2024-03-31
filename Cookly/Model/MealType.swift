//
//  MealType.swift
//  Cookly
//
//  Created by Davit Natenadze on 25.03.24.
//

import Foundation

enum MealType: String, Codable, CaseIterable {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case dinner = "dinner"
}
