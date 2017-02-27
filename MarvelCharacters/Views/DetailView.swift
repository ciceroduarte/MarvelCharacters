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
    
    init() {
        characterView = CharacterView(frame: CGRect.zero)
        loadingView = LoadingView()
        segmentedControl = UISegmentedControl(items: [LocalizedStrings.comics, LocalizedStrings.series])
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.alwaysBounceVertical = true
        
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubviews(views: [characterView, segmentedControl, collectionView, loadingView])
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .black
        
        collectionView.backgroundColor = .white
        backgroundColor = .white
    }
    
    func setupConstraints() {
        
        let characterViewHeight = characterView.height(forWidth: characterView.superview?.frame.width ?? 150.0)
        
        characterView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(characterViewHeight)
        }
        
        segmentedControl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(characterView.snp.bottom)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(1)
        }
        
        loadingView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(1)
        }
    }
}
