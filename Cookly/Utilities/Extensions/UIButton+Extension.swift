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
        setTitleColor(.orange, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.orange.cgColor
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        addAction(UIAction {  _ in
            print(self.titleLabel?.text ?? "empty button title")
                action(self)
        }, for: .touchUpInside)
    }
}
