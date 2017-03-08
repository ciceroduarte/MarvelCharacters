//
//  TransitionFromHomeToDetail.swift
//  MarvelCharacters
//
//  Created by Cicero on 25/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

extension TransitionController {
    
    func from(_ home: HomeViewController,
              toDetail detail: DetailViewController,
              with transitionContext: UIViewControllerContextTransitioning) {
        
        let collectionView = home.contentView.collectionView
        
        guard let index = collectionView.indexPathsForSelectedItems?.first,
            let cell = collectionView.cellForItem(at: index) as? CharacterCell,
            let attributes = collectionView.layoutAttributesForItem(at: index) else {
                
                transitionContext.completeTransition(true)
                return
        }
        
        detail.view.frame = transitionContext.finalFrame(for: detail)
        detail.view.alpha = 0.0
        detail.contentView.layoutIfNeeded()
        
        let cellFrame = collectionView.convert(attributes.frame, to: collectionView.superview)
        
        let originalFrame = CGRect(x: cellFrame.origin.x,
                                   y: cellFrame.origin.y + 64,
                                   width: cellFrame.width,
                                   height: cellFrame.height)
        
        cell.characterView.image.isHidden = true
        detail.contentView.characterView.isHidden = true
        
        let characterView = CharacterView(frame: originalFrame)
        characterView.image.image = cell.characterView.image.image
        
        transitionContext.containerView.addSubview(detail.view)
        transitionContext.containerView.addSubview(characterView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            characterView.frame = CGRect(origin:
                CGPoint(x: detail.contentView.characterView.image.frame.origin.x,
                        y: detail.contentView.characterView.image.frame.origin.y + 56),
                        size: characterView.frame.size)
            
            detail.view.alpha = 1.0
        }) { _ in
            characterView.removeFromSuperview()
            cell.characterView.image.isHidden = false
            detail.contentView.characterView.isHidden = false
            transitionContext.completeTransition(true)
        }
    }
    
}
