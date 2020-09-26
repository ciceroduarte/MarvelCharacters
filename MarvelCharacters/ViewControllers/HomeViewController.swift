//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Cicero on 15/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class HomeViewController: UIViewController {
    
    let viewModel: HomeViewModel
    
    lazy var contentView = HomeView()

    var lastSelectedIndexPath: IndexPath?

    init(withHomeViewModel homeViewModel: HomeViewModel) {
        self.viewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.title
        contentView.delegate = self
        viewModel.viewDelegate = self

        viewModel.loadCharacters()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func charactersDidChange() {
        contentView.showCollectionView()
        contentView.reloadData()
    }

    func fetchDidFailed() {
        contentView.showTryAgain()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        lastSelectedIndexPath = indexPath
        let detailViewController = DetailViewController(withViewModel:
            viewModel.detailViewModel(for: indexPath))
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CharacterCell
        cell.config(withViewModel: viewModel.characterCellViewModel(at: indexPath))
        return cell
    }
}

extension HomeViewController: DynamicHeightLayoutDelegate {
    func collectionView(collectionView: UICollectionView,
                        heightForItemAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        let cell = CharacterCell(frame: CGRect.zero)
        cell.config(withViewModel: viewModel.characterCellViewModel(at: indexPath))
        return cell.height(forWidth: width)
    }
}

extension HomeViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let lastIndexPath = indexPaths.last,
            lastIndexPath.row == viewModel.numberOfCharacters() - 1 else { return }
        viewModel.loadCharacters()
    }
}

extension HomeViewController: DZNEmptyDataSetSource {
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        return LocalizedStrings.emptyData
    }
}

extension HomeViewController: TryAgainDelegate {
    func tryAgain() {
        contentView.showLoadingView()
        viewModel.loadCharacters()
    }
}
