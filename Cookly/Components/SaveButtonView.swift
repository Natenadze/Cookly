//
//  SaveButtonView.swift
//  Cookly
//
//  Created by Davit Natenadze on 11.02.24.
//


import UIKit

class SaveButtonView: UIView {
    
    var isSaved = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





// MARK: - Style & Layout

extension SaveButtonView {
    
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func layout() {
        
        
        NSLayoutConstraint.activate([
            
            
        ])
        
    }
}
