//
//  SettingsView.swift
//  Cookly
//
//  Created by Davit Natenadze on 12.02.24.
//


import UIKit

protocol SettingsViewDelegate: AnyObject {
    func mealTypeButtonTapped(text: String)
    func difficultyButtonTapped(text: String)
}

final class SettingsView: UIView {
    
    enum SettingsType {
        case mealType
        case difficulty
    }
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let optionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    var settingsType: SettingsType?
    weak var delegate: SettingsViewDelegate?
    
    // MARK: - Init
    init(title: String, options: [String], settingsType: SettingsType) {
        self.titleLabel.text = title
        self.settingsType = settingsType
        super.init(frame: .zero)
        setupUI(title: title, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI(title: String, options: [String]) {
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 20)
        addSubview(titleLabel)
        
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(optionsStackView)
        
        
        options.forEach { option in
            let button = UIButton(type: .system)
            button.setupButtonWithTitleAndAction(title: option) { _ in
                self.updateButtonSelection(button)
                self.notifyDelegate(button)
            }
            optionsStackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            optionsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            optionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            optionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            optionsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Helpers
    private func updateButtonSelection(_ sender: UIButton) {
        optionsStackView.arrangedSubviews.forEach {
            if let button = $0 as? UIButton {
                button.backgroundColor = button == sender ? .orange : .systemBackground
                button.setTitleColor(button == sender ? .white : .systemOrange, for: .normal)
                button.titleLabel?.font = button == sender ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 15)
            }
        }
    }
    
    private func notifyDelegate(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        switch settingsType {
        case .mealType:
            delegate?.mealTypeButtonTapped(text: text)
        case .difficulty:
            delegate?.difficultyButtonTapped(text: text)
        case .none:
            return
        }
    }
}
