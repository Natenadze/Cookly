//
//  FavoriteButton.swift
//  Cookly
//
//  Created by Davit Natenadze on 11.02.24.
//


import UIKit

protocol FavoriteButtonDelegate: AnyObject {
    func favoriteButtonTapped(isFavorite: Bool)
}

final class FavoriteButton: UIButton {

    weak var delegate: FavoriteButtonDelegate?
    var isFavorite: Bool = false {
        didSet {
            updateButtonImage()
        }
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.tintColor = .orange
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.imageView?.contentMode = .scaleAspectFit

        self.addAction(UIAction(handler: { [weak self] _ in
            self?.favoriteButtonTapped()
        }), for: .touchUpInside)
    }

    private func favoriteButtonTapped() {
        isFavorite.toggle()
        delegate?.favoriteButtonTapped(isFavorite: isFavorite)
    }

    private func updateButtonImage() {
        let imageName = isFavorite ? "bookmark.fill" : "bookmark"
        self.setImage(UIImage(systemName: imageName), for: .normal)
    }
}


// MARK: - Preview
#Preview {
    FavoriteButton()
}

