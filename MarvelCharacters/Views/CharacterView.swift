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
    private let imageHeight: CGFloat = 145.0
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(views: [name, image])
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func height(forWidth width: CGFloat) -> CGFloat {
        let marginCount = CGFloat(Layout.margin * 3)
        return CGFloat(marginCount + name.height(forWidth: width - CGFloat(Layout.margin * 2)) + imageHeight)
    }
    
    func setupViews() {
        name.font = UIFont.boldSystemFont(ofSize: 16)
        name.numberOfLines = 0
        name.textAlignment = .center
        name.textColor = .black
        
        image.layer.cornerRadius = imageHeight / 2.0
        image.layer.borderWidth = 0.6
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        image.backgroundColor = .white
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Layout.margin)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(imageHeight)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(Layout.margin)
            make.left.equalToSuperview().offset(Layout.margin)
            make.right.equalToSuperview().inset(Layout.margin)
            make.bottom.lessThanOrEqualToSuperview().inset(Layout.margin)
        }
    }
    
    func config(withViewModel viewModel: CharacterCellViewModel) {
        name.text = viewModel.characterName()
        image.kf.setImage(with: viewModel.characterImage())
    }
}
