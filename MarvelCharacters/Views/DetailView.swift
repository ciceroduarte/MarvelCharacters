//
//  DetailView.swift
//  POCView
//
//  Created by Cicero on 30/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    let scrollView: UIScrollView
    let characterView: CharacterView
    let contentView: UIView
    
    init() {
        characterView = CharacterView(frame: CGRect.zero)
        scrollView = UIScrollView()
        contentView = UIView()

        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(characterView)
        
        backgroundColor = .white
        
    }
    
    func setupConstraints() {
        
        let characterViewHeight = characterView.height(forWidth: characterView.superview?.frame.width ?? 150.0)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        characterView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(characterViewHeight)
        }
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(characterView.snp.bottom)
        }
    }
}
