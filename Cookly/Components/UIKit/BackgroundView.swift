//
//  AppBackgroundView.swift
//  Cookly
//
//  Created by Davit Natenadze on 09.02.24.
//

import UIKit

final class BackgroundView: UIView {
    
    // MARK: - Properties
    private let shapeLayer = CAShapeLayer()
    private let logoImageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawBackgroundCurve()
    }
    
    // MARK: - Setup Methods
    private func setup() {
        backgroundColor = .systemGray6
        setupBackgroundLayer()
        setupLogoImageView()
    }
    
    private func setupBackgroundLayer() {
        layer.insertSublayer(shapeLayer, at: 0)
    }
    
    private func setupLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerRadius = 100
        logoImageView.clipsToBounds = true
        
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func drawBackgroundCurve() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: bounds.height * 0.4))
        
        let controlPoint = CGPoint(x: bounds.width / 2, y: (bounds.height * 0.4) + 80)
        path.addQuadCurve(to: CGPoint(x: bounds.width, y: bounds.height * 0.4), controlPoint: controlPoint)
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.close()
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.systemOrange.cgColor
    }
}

#if DEBUG
// MARK: - Preview
#Preview {
    BackgroundView()
}
#endif
