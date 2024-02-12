//
//  RecipeCustomTableViewCell.swift
//  Cookly
//
//  Created by Davit Natenadze on 10.02.24.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let nameLabel = UILabel()
    let quantityLabel = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupViews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .boldSystemFont(ofSize: 16)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.font = .boldSystemFont(ofSize: 16)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(quantityLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            quantityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: quantityLabel.leadingAnchor, constant: -8)
        ])
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        quantityLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func configure(with ingredient: Ingredient) {
        nameLabel.text = "\(ingredient.emoji) \(ingredient.name)"
        quantityLabel.text = ingredient.quantity
    }
}
