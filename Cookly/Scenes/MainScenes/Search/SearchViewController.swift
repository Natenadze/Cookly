//
//  SearchViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 20.01.24.
//

import UIKit
import SwiftUI

final class SearchViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    // MARK: - Properties
    //TODO: - ???
    let horizontalScrollSection = UIHostingController(rootView: ScrollableSection(
        title: "Products",
        images: [
            UIImage(named: "dub")!,
            UIImage(named: "dub")!,
            UIImage(named: "dub")!,
            UIImage(named: "dub")!,
            UIImage(named: "dub")!,
            UIImage(named: "dub")!,
            UIImage(named: "dub")!,
   
        ])
    )
    
    
    // MARK: - UI Elements
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
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search by ingredients"
        label.font = .systemFont(ofSize: 26)
        label.textColor = .white
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
    
    
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
    }

    // MARK: - Methods
    func searchButtonTapped() {
        coordinator?.pushTestVC()
      }
    
}

extension SearchViewController {
    
    func setup() {
        view.backgroundColor = .systemPink
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
        view.addSubview(mainStackView)
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),

        ])
    }
}



