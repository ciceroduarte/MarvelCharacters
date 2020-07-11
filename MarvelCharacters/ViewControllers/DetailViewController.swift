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

class DetailViewController: UIViewController {

    enum Option: Int {
        case comics, series
    }
    
    let detailViewModel: DetailViewModel
    
    lazy var contentView = DetailView()

    var selectedOption: Option {
        return contentView.segmentedControl.selectedSegmentIndex == 0 ? .comics : .series
    }

    init(withViewModel detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        
        super.init(nibName: nil, bundle: nil)
        
        detailViewModel.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = contentView
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
        characterView.image.setImage(with: detailViewModel.characterImage())
        
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
        switch selectedOption {
        case .comics:
            detailViewModel.fetchComics()
        case .series:
            detailViewModel.fetchSeries()
        }
    }
    
    // MARK: Actions
    @objc func tryAgain() {
        contentView.tryAgainView.hide()
        contentView.loadingView.show()
        fetch(withOption: contentView.segmentedControl.selectedSegmentIndex)
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

extension DetailViewController: DetailViewModelDelegate {

    func comicsDidChange() {
        if selectedOption == .comics {
            reloadContent()
        }
    }

    func seriesDidChange() {
        if selectedOption == .series {
            reloadContent()
        }
    }

    func comicsFetchDidFailed() {
        if selectedOption == .comics {
            showTryAgain()
        }
    }

    func seriesFetchDidFailed() {
        if selectedOption == .series {
            showTryAgain()
        }
    }
}

extension DetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedOption == .comics ? detailViewModel.numberOfComics() : detailViewModel.numberOfSeries()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: UICollectionViewCell

        switch selectedOption {
        case .comics:
            cell = comicCell(forIndexPath: indexPath)
        case .series:
            cell = serieCell(forIndexPath: indexPath)
        }
        return cell
    }

    private func comicCell(forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentView.collectionView.dequeueReusableCell(forIndexPath: indexPath) as ComicCell
        cell.config(withImage: detailViewModel.comicImageUrl(withIndex: indexPath),
                    name: detailViewModel.comicTitle(withIndex: indexPath))
        return cell
    }

    private func serieCell(forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentView.collectionView.dequeueReusableCell(forIndexPath: indexPath) as SerieCell
        cell.config(withImage: detailViewModel.serieImageUrl(withIndex: indexPath),
                    name: detailViewModel.serieTitle(withIndex: indexPath))
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.collectionView.frame.width, height: 145)
    }
}

extension DetailViewController: DZNEmptyDataSetSource {
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        return LocalizedStrings.emptyData
    }
}
