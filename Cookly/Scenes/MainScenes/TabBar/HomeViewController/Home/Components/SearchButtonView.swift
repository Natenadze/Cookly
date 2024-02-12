//
//  SearchButtonView.swift
//  Cookly
//
//  Created by Davit Natenadze on 10.02.24.
//

import UIKit

final class SearchButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.backgroundColor = .orange
        self.layer.cornerRadius = 30
        self.contentHorizontalAlignment = .center
        self.setTitle("Start Search", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.4
    }
}

