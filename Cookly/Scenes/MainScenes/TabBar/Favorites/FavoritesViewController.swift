//
//  FavoritesViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import UIKit

final class FavoritesViewController: UIViewController{
    
    // MARK: - Properties
    let viewModel: FavoritesViewModel
    
    // MARK: - UI Components
    private var tableView: UITableView!
    
    // MARK: - Lifecycle
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved Recipes"
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.savedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else {
            fatalError("Cell not found")
        }
        cell.delegate = self
        let recipe = viewModel.savedRecipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.savedRecipes[indexPath.row]
        viewModel.coordinator?.pushRecipeViewController(recipe: recipe)
    }
}

// MARK: - FavoritesTableViewCellDelegate
extension FavoritesViewController: FavoritesTableViewCellDelegate {
    func isSavedButtonTapped(recipe: Recipe) {
        viewModel.handleIsSaveButtonTapped(recipe: recipe)
        tableView.reloadData()
    }
}

