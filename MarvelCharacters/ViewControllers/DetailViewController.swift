//
//  DetailViewController.swift
//  POCView
//
//  Created by Cicero on 30/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DetailViewModelDelegate {
    
    let detailViewModel: DetailViewModel
    
    var contentView: DetailView {
        guard let detailView = view as? DetailView else {
            fatalError("Invalid DetailView")
        }
        return detailView
    }
    
    init(withViewModel detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        
        super.init(nibName: nil, bundle: nil)
        
        detailViewModel.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let barButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
        
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        
        contentView.collectionView.register(ComicCell.self)
        
        let characterView = contentView.characterView
        navigationItem.title = detailViewModel.characterName().uppercased()
        characterView.image.kf.setImage(with: detailViewModel.characterImage())
        
        detailViewModel.fetchComics()
        contentView.showLoading()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return detailViewModel.numberOfComics()
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ComicCell
        cell.config(withImage: detailViewModel.comicImageUrl(withIndex: indexPath),
                    name: detailViewModel.comicTitle(withIndex: indexPath))
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.collectionView.frame.width, height: 145)
    }
        
    // MARK - DetailViewModelDelegate
    func comicsDidChange() {
        contentView.hideLoading()
        contentView.collectionView.reloadData()
    }
}
