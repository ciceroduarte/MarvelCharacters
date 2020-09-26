//
//  TryAgainView.swift
//  MarvelCharacters
//
//  Created by Cicero on 27/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit

protocol TryAgainDelegate: AnyObject {
    func tryAgain()
}

class TryAgainView: UIView {
    
    let tryAgainButton: UIButton
    weak var delegate: TryAgainDelegate?

    init() {
        
        tryAgainButton = UIButton(frame: CGRect.zero)
        
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setupViews() {
        addSubview(tryAgainButton)
        
        backgroundColor = .white
        
        tryAgainButton.setTitle(LocalizedStrings.tryAgain, for: .normal)
        tryAgainButton.tintColor = .black
        tryAgainButton.setTitleColor(.black, for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)

        tryAgainButton.layer.borderWidth = 1.5
        tryAgainButton.layer.borderColor = UIColor.black.cgColor
        tryAgainButton.layer.cornerRadius = 5
        
    }
    
    func setupConstraints() {
        let margin: CGFloat = 20.0
        tryAgainButton.active([
            tryAgainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            tryAgainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            tryAgainButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func show() {
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }

    @objc func tryAgain() {
        delegate?.tryAgain()
    }
}
