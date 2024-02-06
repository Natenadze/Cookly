//
//  RecipeViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 06.02.24.
//


import UIKit

final class RecipeViewController: UIViewController {
    
    // MARK: - Properties
    private var recipe: Recipe
    
    // MARK: -  UI Components
    var imageView = UIImageView()
    var nameLabel = UILabel()
    var detailLabel = UILabel()
    var tableView = UITableView()
    
    
    // MARK: - Lifecycle
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    func setupUI() {
        view.backgroundColor = .systemGray6
        setupImageView()
        setupNameLabel()
        setupDetailLabel()
        setupTableView()
        tableView.reloadData()
    }
}

// MARK: - Extension Methods
private extension RecipeViewController {
    
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: recipe.image)
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])
    }
    
    func setupNameLabel() {
        nameLabel.text = recipe.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupDetailLabel() {
        let diets = recipe.diets.map { $0.rawValue.capitalized }.joined(separator: ", ")
        detailLabel.text = "Diets: \(diets)\nMeal Type: \(recipe.mealType.rawValue.capitalized)\nServings: \(recipe.servings)"
        detailLabel.numberOfLines = 0
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - Extension TableView

extension RecipeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recipe.ingredients.count
        } else {
            return recipe.instructions.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Ingredients"
        } else {
            return "Instructions"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            let ingredient = recipe.ingredients[indexPath.row]
            cell.textLabel?.text = "\(ingredient.emoji)  \(ingredient.name) - \(ingredient.quantity)"
        } else {
            let instruction = recipe.instructions[indexPath.row]
            cell.textLabel?.text = "Step \(indexPath.row + 1): \(instruction)"
            cell.textLabel?.numberOfLines = 0
        }
        
        return cell
    }
}


// MARK: - Preview
#Preview {
    RecipeViewController(recipe: rcp)
}
