//
//  TabBarController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupTabBars()
    }
}

// MARK: - Extension
private extension TabBarController {
    
    func setupTabBars() {
        let searchVC    = UINavigationController(rootViewController: SearchViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        let listVC      = UINavigationController(rootViewController: GroceryListViewController())
        let profileVC   = UINavigationController(rootViewController: ProfileViewController())
        
        searchVC.tabBarItem    = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
        listVC.tabBarItem      = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 2)
        profileVC.tabBarItem   = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        viewControllers = [searchVC, favoritesVC, listVC, profileVC]
    }
    
    func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray5
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}



