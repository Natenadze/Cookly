//
//  SearchViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import UIKit
import SwiftUI

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
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
    
    private let welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Cookly"
        label.font = .boldSystemFont(ofSize: 36)
//        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search by ingredients"
        label.font = .systemFont(ofSize: 26)
//        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    

    private let searchButton: UIButton = {
        let searchButton = UIButton(type: .system)
        searchButton.backgroundColor = .white
        searchButton.layer.cornerRadius = 8
        searchButton.contentHorizontalAlignment = .leading
        
        let searchIcon = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchIcon, for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        
        // Set placeholder text
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.gray, for: .normal)
        
        return searchButton
    }()
    
    //TODO: - ???
    private let horizontalScrollSection = UIHostingController(
        rootView: ScrollableSection(
            title: "Recent searches",
            images: [
                UIImage(named: "dub")!,
                UIImage(named: "dub")!,
                UIImage(named: "dub")!,
                UIImage(named: "dub")!,
                UIImage(named: "dub")!,
                UIImage(named: "dub")!,
                UIImage(named: "dub")!,
            ]
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
    
    // MARK: - Methods
    func searchButtonTapped() {
        coordinator?.pushPromptViewController()
    }
}

// MARK: - Extension
extension SearchViewController {
    
    func setup() {
        view.backgroundColor = .systemGray6
        horizontalScrollSection.view.backgroundColor = .clear
        
        searchButton.addAction(UIAction(handler: { _ in
            self.searchButtonTapped()
        }), for: .touchUpInside)
    }
    
    func layout() {
        mainStackView.addArrangedSubview(welcomeTitle)
        mainStackView.addArrangedSubview(searchTitle)
        mainStackView.addArrangedSubview(searchButton)
        mainStackView.addArrangedSubview(horizontalScrollSection.view)
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
            
            searchButton.heightAnchor.constraint(equalToConstant: 80),
            searchButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
        ])
    }
}


// MARK: - Preview
//#Preview {
//    SearchViewController(coordinator: FlowCoordinator(navigationController: UINavigationController()))
//}



