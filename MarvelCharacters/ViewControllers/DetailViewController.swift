//
//  DetailViewController.swift
//  POCView
//
//  Created by Cicero on 30/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet

class DetailViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource, DetailViewModelDelegate {

    enum Option: Int {
        case comics
        case series
    }
    
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
        contentView.collectionView.emptyDataSetSource = self
        
        contentView.collectionView.register(ComicCell.self)
        contentView.collectionView.register(SerieCell.self)
        
        let characterView = contentView.characterView
        navigationItem.title = detailViewModel.characterName().uppercased()
        characterView.image.kf.setImage(with: detailViewModel.characterImage())
        
        contentView.segmentedControl.addTarget(self, action: #selector(segmentedControlerDidChange), for: .valueChanged)
        contentView.tryAgainView.tryAgainButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        
        detailViewModel.fetchComics()
        contentView.loadingView.show()
    }
    
    @objc func segmentedControlerDidChange(sender: UISegmentedControl) {
        detailViewModel.cancelServices()
        contentView.loadingView.show()
        fetch(withOption: sender.selectedSegmentIndex)
    }
    
    func fetch(withOption option: Int) {
        if option == 0 {
            detailViewModel.fetchComics()
        } else {
            detailViewModel.fetchSeries()
        }
    }
    
    // MARK: Actions
    @objc func tryAgain() {
        contentView.tryAgainView.hide()
        contentView.loadingView.show()
        fetch(withOption: contentView.segmentedControl.selectedSegmentIndex)
    }
    
    // MARK: DZNEmptyDataSetSource
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        return LocalizedStrings.emptyData
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return selectedOption() == .comics ? detailViewModel.numberOfComics() : detailViewModel.numberOfSeries()
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if selectedOption() == .comics {
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ComicCell
            cell.config(withImage: detailViewModel.comicImageUrl(withIndex: indexPath),
                        name: detailViewModel.comicTitle(withIndex: indexPath))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as SerieCell
            cell.config(withImage: detailViewModel.serieImageUrl(withIndex: indexPath),
                        name: detailViewModel.serieTitle(withIndex: indexPath))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.collectionView.frame.width, height: 145)
    }
        
    // MARK: - DetailViewModelDelegate
    func comicsDidChange() {
        if selectedOption() == .comics {
            reloadContent()
        }
    }
    
    func seriesDidChange() {
        if selectedOption() == .series {
            reloadContent()
        }
    }
    
    func comicsFetchDidFailed() {
        if selectedOption() == .comics {
            showTryAgain()
        }
    }
    
    func seriesFetchDidFailed() {
        if selectedOption() == .series {
            showTryAgain()
        }
    }

    func selectedOption() -> Option {
        return Option(rawValue: contentView.segmentedControl.selectedSegmentIndex) ?? .comics
    }
    
    func reloadContent() {
        contentView.tryAgainView.hide()
        contentView.loadingView.hide()
        contentView.collectionView.reloadData()
        contentView.collectionView.isHidden = false
    }
    
    func showTryAgain() {
        contentView.collectionView.isHidden = true
        contentView.tryAgainView.show()
        contentView.loadingView.hide()
    }
    
}
