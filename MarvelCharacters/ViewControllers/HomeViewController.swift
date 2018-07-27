//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Cicero on 15/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,
    HomeViewModelDelegate, DynamicHeightLayoutDelegate, DZNEmptyDataSetSource {
    
    let homeViewModel: HomeViewModel
    
    var contentView: HomeView {
        guard let detailView = view as? HomeView else {
            fatalError("Invalid HomeView")
        }
        return detailView
    }

    init(withHomeViewModel homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MARVEL"
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.collectionView.emptyDataSetSource = self
        contentView.collectionView.register(CharacterCell.self)
        contentView.collectionView.addInfiniteScroll { [weak self] _ -> Void in
            self?.homeViewModel.loadCharacters()
        }
        
        if let layout = contentView.collectionView.collectionViewLayout as? DynamicHeightLayout {
            layout.delegate = self
        }
        
        contentView.tryAgainView.tryAgainButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        
        homeViewModel.viewDelegate = self
        homeViewModel.loadCharacters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    @objc func tryAgain() {
        contentView.showLoadingView()
        homeViewModel.loadCharacters()
    }
    
    // MARK: DZNEmptyDataSetSource
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        return LocalizedStrings.emptyData
    }
    
    // MARK: HomeViewModelDelegate
    internal func charactersDidChange() {
        contentView.showCollectionView()
        contentView.collectionView.finishInfiniteScroll()
        contentView.collectionView.reloadData()
    }
    
    func fetchDidFailed() {
        contentView.showTryAgain()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return homeViewModel.numberOfCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CharacterCell
        cell.config(withViewModel: homeViewModel.characterCellViewModel(at: indexPath))
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let detailViewController = DetailViewController(withViewModel:
            homeViewModel.detailViewModel(for: indexPath))
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: DynamicHeightLayoutDelegate
    func collectionView(collectionView: UICollectionView,
                        heightForItemAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        
        let cell = CharacterCell(frame: CGRect.zero)
        cell.config(withViewModel: homeViewModel.characterCellViewModel(at: indexPath))
        return cell.height(forWidth: width)
    }
}
