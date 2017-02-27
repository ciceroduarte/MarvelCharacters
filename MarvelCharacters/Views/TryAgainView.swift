//
//  TryAgainView.swift
//  MarvelCharacters
//
//  Created by Cicero on 27/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit

class TryAgainView: UIView {
    
    let tryAgainButton: UIButton
    
    init() {
        
        tryAgainButton = UIButton(frame: CGRect.zero)
        
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(tryAgainButton)
        
        tryAgainButton.setTitle(LocalizedStrings.tryAgain, for: .normal)
        tryAgainButton.tintColor = .black
        tryAgainButton.setTitleColor(.black, for: .normal)
        
        tryAgainButton.layer.borderWidth = 1.5
        tryAgainButton.layer.borderColor = UIColor.black.cgColor
        tryAgainButton.layer.cornerRadius = 5
        
    }
    
    func setupConstraints() {
        
        tryAgainButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func show() {
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }
}
