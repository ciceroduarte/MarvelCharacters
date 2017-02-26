//
//  HomeView.swift
//  MarvelCharacters
//
//  Created by Cicero on 26/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    let collectionView: UICollectionView
    let loadingView: LoadingView
    
    init() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: DynamicHeightLayout())
        loadingView = LoadingView()
        
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubviews(views: [collectionView, loadingView])
        
        collectionView.backgroundColor = .white
    }
    
    func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
