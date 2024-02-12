//
//  TabBarController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    weak var coordinator: Coordinator?
    
    // MARK: - LifeCycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupAppearance()
        setupTabBars()
        updateNavBarTitleForSelectedTab()
    }
}

// MARK: - Extension
private extension TabBarController {
    
    func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .systemOrange
    }
    
    func setupTabBars() {
        let searchVC    = HomeViewController(coordinator: coordinator)
        let favoritesVC = FavoritesViewController(coordinator: coordinator)
        let profileVC   = ProfileViewController(coordinator: coordinator)
        
        searchVC.tabBarItem    = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        profileVC.tabBarItem   = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        viewControllers = [searchVC, favoritesVC, profileVC]
    }
}

// MARK: - Extension
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavBarTitleForSelectedTab()
    }
    
    func updateNavBarTitleForSelectedTab() {
        guard let selectedVC = selectedViewController else { return }
        
        switch selectedVC {
        case is HomeViewController:
            navigationItem.title = ""
        case is FavoritesViewController:
            navigationItem.title = "Saved Recipes"
        default:
            navigationItem.title = "Settings"
        }
    }
}
