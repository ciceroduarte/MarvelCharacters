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
    let tryAgainView: TryAgainView
    
    init() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: DynamicHeightLayout())
        loadingView = LoadingView()
        tryAgainView = TryAgainView()
        
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubviews(views: [collectionView, loadingView, tryAgainView])
        
        collectionView.backgroundColor = .white
        tryAgainView.isHidden = true
    }
    
    func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tryAgainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
