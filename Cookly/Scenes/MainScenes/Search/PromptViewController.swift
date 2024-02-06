//
//  PromptViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 05.02.24.
//


import UIKit

final class PromptViewController: UIViewController {
    
    // MARK: - Properties
    weak var coordinator: Coordinator?
    private var isRecipeExtended = false
    private var ingredients: [String] = []
    private let ingredientsLimit = 7
    private var ingredientCounter = 1
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    private let ingredientsTextField = UITextField()
    private let ingredientsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    private let mealTypeTitleLabel = UILabel()
    private let difficultyTitleLabel = UILabel()
    private let extendRecipeLabel = UILabel()
    
    private let breakfastButton = UIButton(type: .system)
    private let lunchButton = UIButton(type: .system)
    private let dinnerButton = UIButton(type: .system)
    private let mealTypeStackView = UIStackView()
    
    private let difficultyEasyButton = UIButton(type: .system)
    private let difficultyMediumButton = UIButton(type: .system)
    private let difficultyHardButton = UIButton(type: .system)
    private let difficultyStackView = UIStackView()
    
    private let extendRecipeToggle = UISwitch()
    
    private let searchButton = UIButton()
    
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
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        layoutUIElements()
        setupTitles()
        setupIngredientsInput()
        setupMealTypeSelection()
        setupDifficultySelection()
        setupExtendRecipeToggle()
        setupGestureRecognizer()
        setupSearchButton()
    }
    
    private func layoutUIElements() {
        addSubviews()
        layout()
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupTitles() {
        titleLabel.configure(with: "What's in your kitchen?", font: .boldSystemFont(ofSize: 26))
        subTitleLabel.configure(with: "Enter up to 7 ingredients", font: .systemFont(ofSize: 18))
        mealTypeTitleLabel.configure(with: "Meal Type", font: .systemFont(ofSize: 20))
        difficultyTitleLabel.configure(with: "Choose Difficulty", font: .systemFont(ofSize: 20))
        extendRecipeLabel.configure(with: "Extend Recipe", font: .systemFont(ofSize: 20))
    }
    
    private func setupMealTypeSelection() {
        mealTypeStackView.axis = .horizontal
        mealTypeStackView.distribution = .fillEqually
        mealTypeStackView.spacing = 10
        
        breakfastButton.setupButton(title: "Breakfast", action: mealTypeSelected)
        lunchButton.setupButton(title: "Lunch", action: mealTypeSelected)
        dinnerButton.setupButton(title: "Dinner", action: mealTypeSelected)
    }
    
    
    private func setupIngredientsInput() {
        ingredientsTextField.placeholder = "Add Ingredient"
        ingredientsTextField.borderStyle = .roundedRect
        ingredientsTextField.delegate = self
    }
    
    private func setupSearchButton() {
        searchButton.setupButton(title: "Search", action: searchButtonTapped)
        searchButton.backgroundColor = .orange
        searchButton.setTitleColor(.white, for: .normal)
    }
    
    
    private func searchButtonTapped(_ sender: UIButton) {
        coordinator?.pushRecipeViewController(recipe: rcp)
    }
    
    
    
    
    //TODO: - Refactor this 
    private func mealTypeSelected(_ sender: UIButton) {
        [breakfastButton, lunchButton, dinnerButton].forEach {
            $0.backgroundColor = $0 == sender ? .orange : .white
            $0.setTitleColor($0 == sender ? .white : .orange, for: .normal)
            $0.titleLabel?.font = $0 == sender  ? .boldSystemFont(ofSize: 18) : .systemFont(ofSize: 16)
        }
    }
    
    private func difficultySelected(_ sender: UIButton) {
        [difficultyEasyButton, difficultyMediumButton, difficultyHardButton].forEach {
            $0.backgroundColor = $0 == sender ? .orange : .white
            $0.setTitleColor($0 == sender ? .white : .orange, for: .normal)
            $0.titleLabel?.font = $0 == sender  ? .boldSystemFont(ofSize: 18) : .systemFont(ofSize: 16)
        }
    }
    
    private func setupExtendRecipeToggle() {
        extendRecipeToggle.isOn = false
        extendRecipeToggle.onTintColor = .orange
        extendRecipeToggle.addTarget(self, action: #selector(extendRecipeToggled(_:)), for: .valueChanged)
        view.addSubview(extendRecipeToggle)
        
        extendRecipeToggle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            extendRecipeToggle.topAnchor.constraint(equalTo: extendRecipeLabel.bottomAnchor, constant: 10),
            extendRecipeToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        let extendRecipeLabel = UILabel()
        extendRecipeLabel.text = "Suggest more ingredients?"
        view.addSubview(extendRecipeLabel)
        
        extendRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            extendRecipeLabel.centerYAnchor.constraint(equalTo: extendRecipeToggle.centerYAnchor),
            extendRecipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupDifficultySelection() {
        difficultyStackView.axis = .horizontal
        difficultyStackView.distribution = .fillEqually
        difficultyStackView.spacing = 10
        
        difficultyEasyButton.setupButton(title: "Easy", action: difficultySelected)
        difficultyMediumButton.setupButton(title: "Medium", action: difficultySelected)
        difficultyHardButton.setupButton(title: "Hard", action: difficultySelected)
    }
    
 
    
    private func addIngredient(_ ingredient: String) {
        let ingredientLabel = UILabel()
        ingredientLabel.text = "\(ingredientCounter). \(ingredient)"
        ingredientLabel.font = .boldSystemFont(ofSize: 18)
        ingredientLabel.textColor = .gray
        ingredientsStackView.addArrangedSubview(ingredientLabel)
        ingredientCounter += 1
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Selectors
    @objc func handleTapOutsideKeyboard(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
    }
    
    @objc func extendRecipeToggled(_ sender: UISwitch) {
        isRecipeExtended = sender.isOn
    }
}

// MARK: - Extension Layout
private extension PromptViewController {
    
    func addSubviews() {
        mealTypeStackView.addArrangedSubview(breakfastButton)
        mealTypeStackView.addArrangedSubview(lunchButton)
        mealTypeStackView.addArrangedSubview(dinnerButton)
        
        difficultyStackView.addArrangedSubview(difficultyEasyButton)
        difficultyStackView.addArrangedSubview(difficultyMediumButton)
        difficultyStackView.addArrangedSubview(difficultyHardButton)
        
        [searchButton, titleLabel, subTitleLabel, mealTypeTitleLabel, difficultyTitleLabel, extendRecipeLabel, ingredientsTextField, ingredientsStackView, mealTypeStackView, difficultyStackView, extendRecipeToggle].forEach(view.addSubview)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            ingredientsTextField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            ingredientsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            ingredientsStackView.topAnchor.constraint(equalTo: ingredientsTextField.bottomAnchor, constant: 10),
            ingredientsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mealTypeTitleLabel.topAnchor.constraint(equalTo: ingredientsStackView.bottomAnchor, constant: 20),
            mealTypeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            mealTypeStackView.topAnchor.constraint(equalTo: mealTypeTitleLabel.bottomAnchor, constant: 10),
            mealTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mealTypeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            difficultyTitleLabel.topAnchor.constraint(equalTo: mealTypeStackView.bottomAnchor, constant: 20),
            difficultyTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            difficultyStackView.topAnchor.constraint(equalTo: difficultyTitleLabel.bottomAnchor, constant: 10),
            difficultyStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            difficultyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            extendRecipeLabel.topAnchor.constraint(equalTo: difficultyStackView.bottomAnchor, constant: 20),
            extendRecipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchButton.topAnchor.constraint(equalTo: extendRecipeLabel.bottomAnchor, constant: 60),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}

// MARK: - Extension UITextFieldDelegate
extension PromptViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let ingredient = textField.text, !ingredient.isEmpty, ingredients.count < ingredientsLimit {
            ingredients.append(ingredient)
            addIngredient(ingredient)
            textField.text = nil
        }
        return false
    }
}



// MARK: - Preview
#Preview {
    PromptViewController(coordinator: FlowCoordinator(navigationController: UINavigationController()))
}
