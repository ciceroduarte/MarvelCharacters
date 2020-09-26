//
//  HomeView.swift
//  MarvelCharacters
//
//  Created by Cicero on 26/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit

typealias HomeViewDelegate = UICollectionViewDataSource &
                                UICollectionViewDelegate &
                                UICollectionViewDataSourcePrefetching &
                                DynamicHeightLayoutDelegate &
                                DZNEmptyDataSetSource &
                                TryAgainDelegate

class HomeView: UIView {
    
    let collectionView: UICollectionView
    private let loadingView = LoadingView()
    private let tryAgainView = TryAgainView()

    weak var delegate: HomeViewDelegate? {
        didSet {
            collectionView.dataSource = delegate
            collectionView.delegate = delegate
            collectionView.prefetchDataSource = delegate
            (collectionView.collectionViewLayout as? DynamicHeightLayout)?.delegate = delegate
            collectionView.emptyDataSetSource = delegate
        }
    }

    init() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: DynamicHeightLayout())
        collectionView.register(CharacterCell.self)

        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setupViews() {
        addSubviews(views: [collectionView, loadingView, tryAgainView])
        
        collectionView.backgroundColor = .white
        collectionView.isAccessibilityElement = true
        collectionView.accessibilityLabel = "collectionView"
        
        tryAgainView.hide()
    }
    
    func showTryAgain() {
        tryAgainView.show()
        loadingView.hide()
        collectionView.isHidden = true
    }
    
    func showLoadingView() {
        loadingView.show()
        tryAgainView.hide()
        collectionView.isHidden = true
    }
    
    func showCollectionView() {
        collectionView.isHidden = false
        loadingView.hide()
        tryAgainView.hide()
    }
    
    func setupConstraints() {
        collectionView.fillSuperview()
        loadingView.fillSuperview()
        tryAgainView.fillSuperview()
    }

    func reloadData() {
        collectionView.reloadData()
    }
}
