//
//  OnboardingViewController.swift
//  Cookly
//
//  Created by Davit Natenadze on 21.03.24.
//

import UIKit

 final class OnboardingVC: UIViewController {
    
    // MARK: - Properties
    var imageName: String
    var titleText: String
    
     // MARK: - UI Components
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    init(imageName: String, titleText: String){
        self.imageName = imageName
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Extension
extension OnboardingVC {
    
    func style() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = titleText
      
    }
    
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}


#Preview {
    OnboardingVC(imageName: "test", titleText: "asdasdas dasd asdas dasd asd asdasd asd asd asd")
}
