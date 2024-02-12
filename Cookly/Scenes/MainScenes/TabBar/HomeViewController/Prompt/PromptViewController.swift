//
//  PromptViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 05.02.24.
//


import UIKit

final class PromptViewController: UIViewController {
    
    // MARK: - Properties
    @Injected(\.mainViewModel) var viewModel: MainViewModel
    weak var coordinator: Coordinator?
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
    
   
    private lazy var mealTypeView = SettingsView(
        title: "Meal Type",
        options: ["Breakfast", "Lunch", "Dinner"],
        settingsType: .mealType
    )
    
    private lazy var difficultyView = SettingsView(
        title: "Choose Difficulty",
        options: ["Easy", "Medium", "Hard"], 
        settingsType: .difficulty
    )

    private let extendRecipeLabel = UILabel()
    private let extendRecipeToggle = UISwitch()
    private let searchButton = UIButton()
    private var activityIndicator = UIActivityIndicatorView()
    
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemOrange
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .natural
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
    
    
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
        view.backgroundColor = .systemBackground
        
        mealTypeView.delegate = self
        difficultyView.delegate = self
        
        layoutUIElements()
        setupTitles()
        setupIngredientsInput()

        setupExtendRecipeToggle()
        setupGestureRecognizer()
        setupSearchButton()
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.style = .large
        activityIndicator.color = .systemOrange
        activityIndicator.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
        extendRecipeLabel.configure(with: "Extend Recipe", font: .systemFont(ofSize: 20))
    }
    

    
    private func setupIngredientsInput() {
        ingredientsTextField.placeholder = "Add Ingredient"
        ingredientsTextField.layer.cornerRadius = 20
        ingredientsTextField.layer.borderWidth = 1
        ingredientsTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        ingredientsTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ingredientsTextField.delegate = self
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
         ingredientsTextField.leftView = paddingView
         ingredientsTextField.leftViewMode = .always
    }
    
    private func setupSearchButton() {
        searchButton.setupButtonWithTitleAndAction(title: "Search", action: searchButtonTapped)
        searchButton.backgroundColor = .orange
        searchButton.setTitleColor(.white, for: .normal)
    }
    

    
    private func setupExtendRecipeToggle() {
        extendRecipeToggle.isOn = false
        extendRecipeToggle.onTintColor = .orange
        extendRecipeToggle.addAction(UIAction(handler: { [weak self] _ in
            self?.extendRecipeToggled(isOn: self?.extendRecipeToggle.isOn ?? false)
        }), for: .valueChanged)
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

    
    private func searchButtonTapped(_ sender: UIButton) {
        guard viewModel.prompt.ingredients.count >= 2 else {
            showErrorLabel(text: " 🌶️  Please Enter at least 2 ingredients")
            return
        }
        
        activityIndicator.startAnimating()
        
        viewModel.generateRecipe() { [weak self] result in
            guard let self = self else { return }
            
            self.activityIndicator.stopAnimating()
            
            if let recipe = result {
                self.coordinator?.pushRecipeViewController(recipe: recipe)
            } else {
                self.showErrorLabel(text: " 🌐 - Network error, try again later")
            }
        }
    }
    
    
    // MARK: - Selectors
    @objc func handleTapOutsideKeyboard(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
    }
    
    func extendRecipeToggled(isOn: Bool) {
        viewModel.prompt.extendRecipe = isOn
    }
    
    private func showErrorLabel(text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.errorLabel.transform = CGAffineTransform(
                translationX: 0,
                y: self.errorLabel.frame.height + self.view.safeAreaInsets.top - 10
            )
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 3.0, options: [], animations: {
                self.errorLabel.transform = .identity
            }) { _ in
                self.errorLabel.isHidden = true
            }
        }
    }
    
}

// MARK: - Extension Layout
private extension PromptViewController {
    
    func addSubviews() {
        [searchButton, titleLabel, subTitleLabel, mealTypeView, difficultyView, extendRecipeLabel, ingredientsTextField, ingredientsStackView, extendRecipeToggle, errorLabel].forEach(view.addSubview)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            
            errorLabel.bottomAnchor.constraint(equalTo: view.topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorLabel.heightAnchor.constraint(equalToConstant: 70),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            ingredientsTextField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            ingredientsTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ingredientsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            ingredientsStackView.topAnchor.constraint(equalTo: ingredientsTextField.bottomAnchor, constant: 10),
            ingredientsStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ingredientsStackView.trailingAnchor.constraint(equalTo: ingredientsTextField.trailingAnchor),
            
            mealTypeView.topAnchor.constraint(equalTo: ingredientsStackView.bottomAnchor, constant: 20),
            mealTypeView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            mealTypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), 
            
            difficultyView.topAnchor.constraint(equalTo: mealTypeView.bottomAnchor, constant: 20),
            difficultyView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            difficultyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            extendRecipeLabel.topAnchor.constraint(equalTo: difficultyView.bottomAnchor, constant: 20),
            extendRecipeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            searchButton.topAnchor.constraint(equalTo: extendRecipeLabel.bottomAnchor, constant: 60),
            searchButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}

// MARK: - Extension Ingredient adding setup
extension PromptViewController {
    
    private func addIngredient(_ ingredient: String) {
        viewModel.prompt.ingredients.append(ingredient)
        let ingredientView = createIngredientView(at: ingredientCounter, with: ingredient, index: ingredientCounter - 1)
        ingredientsStackView.addArrangedSubview(ingredientView)
        ingredientCounter += 1
        self.view.layoutIfNeeded()
    }
    
    private func createIngredientView(at number: Int, with ingredient: String, index: Int) -> UIView {
        let container = UIView()
        container.layer.cornerRadius = 15
        container.layer.borderWidth = 1.5
        container.layer.borderColor = UIColor.systemGray4.cgColor
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let numberLabel = UILabel()
        numberLabel.text = "\(number)."
        numberLabel.font = .boldSystemFont(ofSize: 16)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let ingredientLabel = UILabel()
        ingredientLabel.text = ingredient
        ingredientLabel.font = .systemFont(ofSize: 14)
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("x", for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = .gray
        deleteButton.layer.cornerRadius = 9
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        let action = UIAction { [weak self] _ in
            if let containerView = deleteButton.superview?.superview,
               let index = self?.ingredientsStackView.arrangedSubviews.firstIndex(of: containerView) {
                self?.deleteIngredient(index)
            }
        }
        deleteButton.addAction(action, for: .touchUpInside)
        let horizontalStackView = UIStackView(arrangedSubviews: [numberLabel, container])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 9
        horizontalStackView.alignment = .center
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(ingredientLabel)
        container.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            ingredientLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            ingredientLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            ingredientLabel.trailingAnchor.constraint(lessThanOrEqualTo: deleteButton.leadingAnchor, constant: -10),
            
            deleteButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            deleteButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 18),
            deleteButton.heightAnchor.constraint(equalToConstant: 18),
            
            container.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        return horizontalStackView
    }
    
    
    private func deleteIngredient(_ index: Int) {
        guard index < viewModel.prompt.ingredients.count else { return }
        viewModel.removeIngredientFromPromptAtIndex(index)
        ingredientsStackView.arrangedSubviews[index].removeFromSuperview()
        updateIngredientViews()
    }
    
    
    private func updateIngredientViews() {
        ingredientCounter = 1
        for view in ingredientsStackView.arrangedSubviews {
            if let stackView = view as? UIStackView,
               let numberLabel = stackView.arrangedSubviews.first(where: { $0 is UILabel }) as? UILabel {
                numberLabel.text = "\(ingredientCounter)."
                ingredientCounter += 1
            }
        }
    }
}

// MARK: - Extension UITextFieldDelegate
extension PromptViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let ingredient = textField.text, !ingredient.isEmpty, viewModel.prompt.ingredients.count < ingredientsLimit {
            addIngredient(ingredient)
            textField.text = nil
        }
        return false
    }
}

// MARK: - Extension SettingsViewDelegate
extension PromptViewController: SettingsViewDelegate {
    func mealTypeButtonTapped(text: String) {
        viewModel.updateMealType(text: text)
    }
    
    func difficultyButtonTapped(text: String) {
        viewModel.updateDifficulty(text: text)
    }
}




#if DEBUG
// MARK: - Preview
#Preview {
    let nav = UINavigationController()
    let coordinator = FlowCoordinator(navigationController: nav)
    return PromptViewController(coordinator: coordinator)
}
#endif
