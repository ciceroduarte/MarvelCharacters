//
//  SerieCell.swift
//  MarvelCharacters
//
//  Created by Cicero on 27/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class SerieCell: UICollectionViewCell, Reusable {
    
    lazy var name = UILabel()
    lazy var image = UIImageView()

    private let imageHeight: CGFloat = 145.0
    
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
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Layout.margin)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Layout.margin)
            make.height.equalTo(imageHeight)
            make.width.equalTo(97)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Layout.margin)
            make.left.equalTo(image.snp.right).offset(Layout.margin)
            make.right.equalToSuperview().inset(Layout.margin)
            make.bottom.lessThanOrEqualToSuperview().inset(Layout.margin)
        }
    }
    
    func config(withImage imageUrl: URL?, name: String) {
        self.name.text = name
        image.kf.setImage(with: imageUrl)
    }
}
