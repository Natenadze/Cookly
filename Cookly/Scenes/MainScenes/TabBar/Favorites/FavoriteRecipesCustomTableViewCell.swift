//
//  FavoritesTableViewCell.swift
//  Cookly
//
//  Created by Davit Natenadze on 08.02.24.
//

import UIKit

protocol FavoritesTableViewCellDelegate: AnyObject {
    func isSavedButtonTapped(recipe: Recipe)
}

final class FavoritesTableViewCell: UITableViewCell {
    
    static var identifier: String {
        .init(describing: self)
    }
    
    private var isSaved = false {
        didSet {
            updateFavoriteButton()
        }
    }
    
    private var recipe: Recipe?
    
    weak var delegate: FavoritesTableViewCellDelegate?
    
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "test")
        return imageView
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.locations = [0, 1]
        view.layer.insertSublayer(gradient, at: 0)
        return view
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .orange
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let timeIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "clock"))
        imageView.tintColor = .white
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
        containerView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(gradientView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeIconImageView)
        containerView.addSubview(timeLabel)
        containerView.addSubview(favoriteButton)
        
        favoriteButton.addAction(UIAction(handler: { _ in
            self.favoriteButtonTapped()
        }), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let spacing: CGFloat = 16
        containerView.frame = contentView.bounds.insetBy(dx: spacing, dy: spacing / 2)
        
        backgroundImageView.frame = containerView.bounds
        gradientView.frame = containerView.bounds
        gradientView.layer.sublayers?.first?.frame = gradientView.bounds
        
        titleLabel.frame = CGRect(x: 10, y: containerView.frame.height - 60, width: containerView.frame.width - 130, height: 50)
        timeIconImageView.frame = CGRect(x: containerView.frame.width - 100, y: containerView.frame.height - 50, width: 25, height: 25)
        timeLabel.frame = CGRect(x: containerView.frame.width - 70, y: containerView.frame.height - 50, width: 60, height: 25)
        
        favoriteButton.frame = CGRect(x: containerView.frame.width - 40, y: 10, width: 30, height: 30)
    }
    
    func configure(with recipe: Recipe) {
        self.recipe = recipe
        backgroundImageView.image = UIImage(named: recipe.image)
        titleLabel.text = recipe.name
        timeLabel.text = String(recipe.time)
        isSaved = recipe.isSaved
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        UIView.transition(with: favoriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self else { return }
            let imageName = self.isSaved ? "bookmark.fill" : "bookmark"
            self.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        }, completion: nil)
    }
    
    private func favoriteButtonTapped() {
        guard let recipe else { return }
        delegate?.isSavedButtonTapped(recipe: recipe)
    }
    
}
