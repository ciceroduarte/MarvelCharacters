//
//  CharacterView.swift
//  MarvelCharacters
//
//  Created by Cicero on 25/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

class CharacterView: UIView {
    
    let name = UILabel()
    let image = UIImageView()
    private let imageWidthHeight: CGFloat = 145.0
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.addSubviews(views: [name, image])
        setupViews()
        setupConstraints()
    }
    
    func height(forWidth width: CGFloat) -> CGFloat {
        let marginCount = CGFloat(Layout.margin * 3)
        return CGFloat(marginCount + name.height(forWidth: width - CGFloat(Layout.margin * 2)) + imageWidthHeight)
    }
    
    func setupViews() {
        name.font = UIFont.boldSystemFont(ofSize: 16)
        name.numberOfLines = 0
        name.textAlignment = .center
        name.textColor = .black
        
        image.layer.cornerRadius = imageWidthHeight / 2.0
        image.layer.borderWidth = 0.6
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        image.backgroundColor = .white
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        image.active([
            image.topAnchor.constraint(equalTo: topAnchor, constant: Layout.margin),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: imageWidthHeight),
            image.heightAnchor.constraint(equalToConstant: imageWidthHeight)
        ])

        name.active([
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Layout.margin),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.margin),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.margin),
            name.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: Layout.margin)
        ])
    }
    
    func config(withViewModel viewModel: CharacterCellViewModel) {
        name.text = viewModel.characterName()
        image.setImage(with: viewModel.characterImage())
    }
}
