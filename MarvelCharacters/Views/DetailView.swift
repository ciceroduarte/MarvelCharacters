//
//  DetailView.swift
//  POCView
//
//  Created by Cicero on 30/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    let characterView: CharacterView
    let loadingView: LoadingView
    
    init() {
        characterView = CharacterView(frame: CGRect.zero)
        loadingView = LoadingView()

        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubviews(views: [characterView, loadingView])
        
        backgroundColor = .white
    }
    
    func setupConstraints() {
        
        let characterViewHeight = characterView.height(forWidth: characterView.superview?.frame.width ?? 150.0)
        
        characterView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(characterViewHeight)
        }
        
        loadingView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(characterView.snp.bottom)
        }
    }
}
