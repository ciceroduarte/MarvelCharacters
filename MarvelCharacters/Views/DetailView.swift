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
    let segmentedControl: UISegmentedControl
    let collectionView: UICollectionView
    let tryAgainView: TryAgainView
    
    init() {
        characterView = CharacterView()
        loadingView = LoadingView()
        segmentedControl = UISegmentedControl(items: [LocalizedStrings.comics, LocalizedStrings.series])
        tryAgainView = TryAgainView()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.alwaysBounceVertical = true
        
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setupViews() {
        addSubviews(views: [characterView, segmentedControl, collectionView, tryAgainView, loadingView])
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .black
        
        collectionView.backgroundColor = .white
        collectionView.isAccessibilityElement = true
        collectionView.accessibilityLabel = "collectionView"
        backgroundColor = .white
        tryAgainView.hide()
    }
    
    func setupConstraints() {
        
        let characterViewHeight = characterView.height(forWidth: frame.width)
        let margin: CGFloat = 8.0

        characterView.active([
            characterView.topAnchor.constraint(equalTo: topAnchor),
            characterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterView.heightAnchor.constraint(equalToConstant: characterViewHeight)
        ])

        segmentedControl.active([
            segmentedControl.topAnchor.constraint(equalTo: characterView.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin)
        ])

        collectionView.active([
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin)
        ])

        loadingView.active([
            loadingView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        tryAgainView.active([
            tryAgainView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tryAgainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tryAgainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tryAgainView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
