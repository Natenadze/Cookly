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
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let logoContainerView = LogoContainerView()
    private let searchButton = SearchButtonView()
    
    private let recentSearchesScrollView = UIHostingController(
        rootView: ScrollableSection(
            title: "Recent searches",
            recipes: []
        )
    )
    
    private let popularRecipesScrollView = UIHostingController(
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
        let gradientView = CustomLinearGradientView(frame: view.bounds)
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor, constant: -80),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
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
        navigationController?.navigationBar.isHidden = false
        recentSearchesScrollView.rootView.recipes = viewModel.allRecipes
        recentSearchesScrollView.view.invalidateIntrinsicContentSize()
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
        recentSearchesScrollView.view.backgroundColor = .clear
        recentSearchesScrollView.rootView.delegate = self
        
        popularRecipesScrollView.view.backgroundColor = .clear
        popularRecipesScrollView.rootView.delegate = self
        
        searchButton.addAction(UIAction(handler: { _ in
            self.searchButtonTapped()
        }), for: .touchUpInside)
    }
    
    func layout() {
        mainStackView.addArrangedSubview(welcomeTitle)
        centeredStackView.addArrangedSubview(logoContainerView)
        centeredStackView.addArrangedSubview(searchButton)
        mainStackView.addArrangedSubview(centeredStackView)
        mainStackView.addArrangedSubview(recentSearchesScrollView.view)
        mainStackView.addArrangedSubview(popularRecipesScrollView.view)
        scrollView.addSubview(mainStackView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoContainerView.heightAnchor.constraint(equalToConstant: 160),
            logoContainerView.widthAnchor.constraint(equalToConstant: 160),
            logoContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
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


#if DEBUG
// MARK: - Preview
#Preview {
    let coordinator = FlowCoordinator(navigationController: UINavigationController())
    return HomeViewController(coordinator: coordinator)
}
#endif


