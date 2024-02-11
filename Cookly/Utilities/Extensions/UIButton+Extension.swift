//
//  UIButton+Extension.swift
//  Cookly
//
//  Created by Davit Natenadze on 06.02.24.
//

import UIKit

extension UIButton {
    
    func setupButton(title: String, action: @escaping (UIButton) -> Void) {
        setTitle(title, for: .normal)
        setTitleColor(.systemOrange, for: .normal)
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemOrange.cgColor
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        addAction(UIAction {  _ in
            action(self)
        }, for: .touchUpInside)
    }
}
