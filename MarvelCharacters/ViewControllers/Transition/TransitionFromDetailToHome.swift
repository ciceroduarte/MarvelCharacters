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

        guard let index = home.lastSelectedIndexPath,
            let cell = collectionView.cellForItem(at: index) as? CharacterCell,
            let attributes = collectionView.layoutAttributesForItem(at: index) else {
                transitionContext.completeTransition(true)
                return
        }
        
        home.view.frame = transitionContext.finalFrame(for: home)
        home.view.alpha = 0.0

        let cellOrigin = collectionView.convert(attributes.frame.origin, to: collectionView.superview)
        let contentViewY = detail.contentView.frame.origin.y

        let image = imageView(fromCharacterCell: cell)
        image.frame.origin = CGPoint(x: detail.contentView.characterView.image.frame.origin.x,
                              y: detail.contentView.characterView.image.frame.origin.y + contentViewY)
        
        detail.contentView.characterView.image.isHidden = true
        cell.characterView.image.isHidden = true
        collectionView.isHidden = false

        transitionContext.containerView.addSubview(home.view)
        transitionContext.containerView.addSubview(image)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            image.frame.origin = CGPoint(x: cellOrigin.x + cell.characterView.image.frame.origin.x,
                                         y: cellOrigin.y + cell.characterView.image.frame.origin.y + contentViewY)

            home.view.alpha = 1.0
        }, completion: { _ in
            image.removeFromSuperview()
            cell.characterView.image.isHidden = false
            
            transitionContext.completeTransition(true)
        })
    }
}
