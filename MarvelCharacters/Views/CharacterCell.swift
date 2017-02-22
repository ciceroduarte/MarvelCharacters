//
//  HeroTableViewCell.swift
//  POCView
//
//  Created by Cicero on 22/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterCell: UICollectionViewCell, Reusable {
    
    private let characterName = UILabel()
    private let characterImage = UIImageView()
    private let imageHeight: CGFloat = 130.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubviews(views: [characterName, characterImage])
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func height(forWidth width: CGFloat) -> CGFloat {
        let marginCount = CGFloat(Layout.margin * 3)
        return CGFloat(marginCount + characterName.height(forWidth: width - CGFloat(Layout.margin * 2)) + imageHeight)
    }
    
    func setupViews() {
        characterName.font = UIFont.boldSystemFont(ofSize: 18)
        characterName.numberOfLines = 0
        characterName.textAlignment = .center
        characterName.textColor = .white
        
        characterImage.layer.cornerRadius = imageHeight / 2.0
//        characterImage.layer.borderWidth = 0.8
//        characterImage.layer.borderColor = UIColor.black.cgColor
        characterImage.clipsToBounds = true
        characterImage.backgroundColor = .white
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        
        characterImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Layout.margin)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(imageHeight)
        }
        
        characterName.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(Layout.margin)
            make.left.equalToSuperview().offset(Layout.margin)
            make.right.equalToSuperview().inset(Layout.margin)
            make.bottom.lessThanOrEqualToSuperview().inset(Layout.margin)
        }
    }
    
    func config(withViewModel viewModel: CharacterCellViewModel) {
        characterName.text = viewModel.characterName()
        characterImage.kf.setImage(with: viewModel.characterImage())
    }
}
