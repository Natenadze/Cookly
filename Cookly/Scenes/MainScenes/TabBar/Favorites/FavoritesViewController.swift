//
//  FavoritesViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import UIKit

final class FavoritesViewController: UIViewController{
    
    // MARK: - Properties
//    var favoriteRecipes = [Recipe]()
    var favoriteRecipes = recipesArray
    weak var coordinator: Coordinator?
    
    // MARK: - UI Components
    private var tableView: UITableView!
    
    // MARK: - Lifecycle
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved Recipes"
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = 200
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
 
}

extension FavoritesViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Cell not found")
        }
        
        let recipe = favoriteRecipes[indexPath.row]
        //TODO: - refactor
        cell.configure(
            with: recipe.name,
            imageName: "test",
            time: "\(recipe.time) min"
        )
        return cell
    }
}



// MARK: - Preview
#Preview {
    let coordinator = FlowCoordinator(navigationController: UINavigationController())
    return FavoritesViewController(coordinator: coordinator)
}
