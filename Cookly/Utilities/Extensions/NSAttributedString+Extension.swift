//
//  NSAttributedString+Extension.swift
//  Cookly
//
//  Created by Davit Natenadze on 10.02.24.
//

import UIKit

extension NSAttributedString {
    static func attributedStringForInstruction(stepNumber: Int, instruction: String) -> NSAttributedString {
        let stepText = "Step \(stepNumber): "
        let attributedString = NSMutableAttributedString(
            string: stepText,
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.systemOrange
            ])
        
        let instructionText = NSAttributedString(
            string: instruction,
            attributes: [
                .font: UIFont.systemFont(ofSize: 14)
            ])
        
        attributedString.append(instructionText)
        return attributedString
    }
}
