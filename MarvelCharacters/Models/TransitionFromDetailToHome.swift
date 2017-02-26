//
//  TransitionFromDetailToHome.swift
//  MarvelCharacters
//
//  Created by Cicero on 25/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

extension TransitionController {

    func from(_ detail: DetailViewController,
              toHome home: HomeViewController,
              with transitionContext: UIViewControllerContextTransitioning) {
        
        let collectionView = home.contentView.collectionView
        
        guard let index = collectionView.indexPathsForSelectedItems?.first,
            let cell = collectionView.cellForItem(at: index) as? CharacterCell,
            let attributes = collectionView.layoutAttributesForItem(at: index) else {

                transitionContext.containerView.addSubview(home.view)
                transitionContext.completeTransition(true)
                return
        }
        
        home.view.frame = transitionContext.finalFrame(for: home)
        home.view.alpha = 0.0
        
        transitionContext.containerView.addSubview(home.view)
        
        let cellFrame = collectionView.convert(attributes.frame, to: collectionView.superview)
        
        let originalFrame = CGRect(origin:
            CGPoint(x: detail.contentView.characterView.image.frame.origin.x,
                    y: detail.contentView.characterView.image.frame.origin.y + 56),
                    size: detail.contentView.frame.size)

        detail.contentView.characterView.image.isHidden = true
        cell.characterView.image.isHidden = true
        collectionView.isHidden = false
        
        let characterView = CharacterView(frame: originalFrame)
        characterView.image.image = cell.characterView.image.image
        
        transitionContext.containerView.addSubview(characterView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            characterView.frame = CGRect(x: cellFrame.origin.x,
                                         y: cellFrame.origin.y + 64,
                                         width: cellFrame.width,
                                         height: cellFrame.height)
            home.view.alpha = 1.0
        }) { _ in
            characterView.removeFromSuperview()
            cell.characterView.image.isHidden = false
            
            transitionContext.completeTransition(true)
        }
    }
}
