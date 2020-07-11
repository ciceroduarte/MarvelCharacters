//
//  SerieCell.swift
//  MarvelCharacters
//
//  Created by Cicero on 27/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit

class SerieCell: UICollectionViewCell, Reusable {
    
    lazy var name = UILabel()
    lazy var image = UIImageView()

    private let imageHeight: CGFloat = 145.0
    private let imageWidth: CGFloat = 97.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(views: [name, image])
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setupViews() {
        name.font = UIFont.boldSystemFont(ofSize: 16)
        name.numberOfLines = 0
        name.textAlignment = .left
        name.textColor = .black
        
        image.layer.borderWidth = 0.6
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        image.backgroundColor = .white
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        image.active([
            image.topAnchor.constraint(equalTo: topAnchor, constant: Layout.margin),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.widthAnchor.constraint(equalToConstant: imageWidth),
            image.heightAnchor.constraint(equalToConstant: imageHeight),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.margin)
        ])

        name.active([
            name.topAnchor.constraint(equalTo: topAnchor, constant: Layout.margin),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Layout.margin),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.margin),
            name.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: Layout.margin)
        ])
    }
    
    func config(withImage imageUrl: URL?, name: String) {
        self.name.text = name
        image.setImage(with: imageUrl)
    }
}
