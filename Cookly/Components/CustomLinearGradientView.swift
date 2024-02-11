//
//  CustomLinearGradientView.swift
//  Cookly
//
//  Created by Davit Natenadze on 11.02.24.
//

import UIKit

class CustomLinearGradientView: UIView {
    var colors: [CGColor] = [UIColor.systemOrange.cgColor, UIColor.white.cgColor]
    var colorLocations: [CGFloat] = [0.0, 0.5]

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return }
        
        let startPoint = CGPoint(x: bounds.midX, y: bounds.minY)
        let endPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
}
