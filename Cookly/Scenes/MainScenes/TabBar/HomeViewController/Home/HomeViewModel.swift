//
//  HomeViewModel.swift
//  Cookly
//
//  Created by Davit Natenadze on 26.03.24.
//

import Foundation

final class HomeViewModel {
    
    @Injected(\.recipeStorage) var recipeStorage: RecipeStorage
    
    weak var coordinator: Coordinator?
    
    var allRecipes = [Recipe]() {
        didSet {
            recipeStorage.saveRecipes()
        }
    }
    
    // MARK: - LifeCycle
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
        allRecipes = recipeStorage.loadRecentRecipes()
    }
    
}
