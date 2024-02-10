//
//  HomeViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import UIKit
import SwiftUI

protocol ScrollViewDelegate {
    func navigateToRecipeViewController(recipe: Recipe)
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    @Injected(\.mainViewModel) var viewModel: MainViewModel
    weak var coordinator: Coordinator?
    
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.alignment = .top
        stack.axis = .vertical
        return stack
    }()
    
    private let centeredStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12
        return stack
    }()
    
    private let welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back!"
        label.font = .boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        return label
    }()
    
    
    private let logoContainerView: UIView = {
        let logoContainerView = UIView()
        logoContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ai1")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 80
        image.clipsToBounds = true
        
        logoContainerView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: logoContainerView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: logoContainerView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 160),
            image.heightAnchor.constraint(equalToConstant: 160),
        ])
        
        return logoContainerView
    }()
    
    
    private let searchButton: UIButton = {
        let searchButton = UIButton(type: .system)
        searchButton.backgroundColor = .orange
        searchButton.layer.cornerRadius = 30
        searchButton.contentHorizontalAlignment = .center
        searchButton.setTitle("Start Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        searchButton.layer.shadowRadius = 5
        searchButton.layer.shadowOpacity = 0.4
        return searchButton
    }()
    
    //TODO: - ???
    private let horizontalScrollSection = UIHostingController(
        rootView: ScrollableSection(
            title: "Recent searches",
            recipes: []
        )
    )
    
    private let horizontalScrollSection2 = UIHostingController(
        rootView: ScrollableSection(
            title: "Popular",
            recipes: recipesArray
        )
    )
    
    // MARK: - LifeCycle
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        DispatchQueue.main.async {
            self.animateSearchButton()
        }
    }
    
    // MARK: - Methods
    func updateUI() {
        
        horizontalScrollSection.rootView.recipes = viewModel.allRecipes
        horizontalScrollSection.view.invalidateIntrinsicContentSize()
    }
    
    func searchButtonTapped() {
        coordinator?.pushPromptViewController()
    }
    
    func animateSearchButton() {
        searchButton.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: [.repeat, .autoreverse, .allowUserInteraction],
                       animations: {
            self.searchButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }

}

// MARK: - Extension
extension HomeViewController {
    
    func setup() {
        view.backgroundColor = .systemGray6
        horizontalScrollSection.view.backgroundColor = .clear
        horizontalScrollSection.rootView.delegate = self
        horizontalScrollSection2.rootView.delegate = self
        horizontalScrollSection2.view.backgroundColor = .clear
        
        horizontalScrollSection.rootView.recipes = viewModel.savedRecipes
        
        searchButton.addAction(UIAction(handler: { _ in
            self.searchButtonTapped()
        }), for: .touchUpInside)
    }
    
    func layout() {
        mainStackView.addArrangedSubview(welcomeTitle)
        centeredStackView.addArrangedSubview(logoContainerView)
        centeredStackView.addArrangedSubview(searchButton)
        mainStackView.addArrangedSubview(centeredStackView)
        mainStackView.addArrangedSubview(horizontalScrollSection.view)
        mainStackView.addArrangedSubview(horizontalScrollSection2.view)
        scrollView.addSubview(mainStackView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoContainerView.heightAnchor.constraint(equalToConstant: 160),
            logoContainerView.widthAnchor.constraint(equalToConstant: 160),
            logoContainerView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            logoContainerView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            searchButton.heightAnchor.constraint(equalToConstant: 60),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}

// MARK: - extension ScrollViewDelegate
extension HomeViewController: ScrollViewDelegate {
    func navigateToRecipeViewController(recipe: Recipe) {
        coordinator?.pushRecipeViewController(recipe: recipe)
    }
    
    
}


// MARK: - Preview
#Preview {
    let coordinator = FlowCoordinator(navigationController: UINavigationController())
    return HomeViewController(coordinator: coordinator)
}



