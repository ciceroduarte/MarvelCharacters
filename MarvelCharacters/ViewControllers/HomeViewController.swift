//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Cicero on 15/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, HomeViewModelDelegate, DynamicHeightLayoutDelegate {
    
    let homeViewModel: HomeViewModel
    
    init(withHomeViewModel homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(collectionViewLayout:DynamicHeightLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MARVEL"
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CharacterCell.self)
        collectionView?.addInfiniteScroll { [weak self] _ -> Void in
            self?.homeViewModel.loadCharacters()
        }
        
        if let layout = collectionView?.collectionViewLayout as? DynamicHeightLayout {
            layout.delegate = self
        }
        
        self.collectionView?.backgroundColor = .red
        
        homeViewModel.viewDelegate = self
        homeViewModel.loadCharacters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func charactersDidChange() {
        collectionView?.finishInfiniteScroll()
        self.collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.numberOfCharacters()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CharacterCell
        cell.config(withViewModel: homeViewModel.characterCellViewModel(at: indexPath))
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        navigationController?.setNavigationBarHidden(false, animated: true)
//        let detailViewController = DetailViewController(withViewModel: 
        //homeViewModel.detailViewModel(forIndexPath: indexPath))
//        navigationController?.pushViewController(detailViewController, animated: true)
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
