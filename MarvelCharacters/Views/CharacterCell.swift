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

    lazy var characterView = CharacterView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(views: [characterView])
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func height(forWidth width: CGFloat) -> CGFloat {
        return characterView.height(forWidth: width)
    }
    
    func setupViews() {
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        characterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func config(withViewModel viewModel: CharacterCellViewModel) {
        characterView.config(withViewModel: viewModel)
    }
}
