//
//  CustomLinearGradientView.swift
//  Cookly
//
//  Created by Davit Natenadze on 11.02.24.
//

import UIKit


final class CustomLinearGradientView: UIView {
    
    var lightModeColors: [CGColor] = [UIColor.systemOrange.cgColor, UIColor.white.cgColor]
    var darkModeColors: [CGColor] = [UIColor.systemOrange.cgColor, UIColor.black.cgColor]
    
    var currentColors: [CGColor] {
        switch traitCollection.userInterfaceStyle {
        case .dark: return darkModeColors
        default: return lightModeColors
        }
    }
    
    var colorLocations: [CGFloat] = [0.0, 0.5]

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: currentColors as CFArray,
            locations: colorLocations
        ) else { return }
        
        let startPoint = CGPoint(x: bounds.midX, y: bounds.minY)
        let endPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
}
