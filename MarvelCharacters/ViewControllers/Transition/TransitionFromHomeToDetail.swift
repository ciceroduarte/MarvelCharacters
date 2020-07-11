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
        
        guard let index = home.lastSelectedIndexPath,
            let cell = collectionView.cellForItem(at: index) as? CharacterCell,
            let attributes = collectionView.layoutAttributesForItem(at: index) else {
                
                transitionContext.completeTransition(false)
                return
        }
        
        detail.view.frame = transitionContext.finalFrame(for: detail)
        detail.view.alpha = 0.0

        detail.contentView.layoutIfNeeded()

        let image = imageView(fromCharacterCell: cell)

        let cellOrigin = collectionView.convert(attributes.frame.origin, to: nil)
        let contentViewY = detail.view.convert(detail.contentView.frame.origin, to: nil).y

        image.frame.origin = CGPoint(x: image.frame.origin.x + cellOrigin.x,
                                     y: image.frame.origin.y + cellOrigin.y)
        
        cell.characterView.image.isHidden = true
        detail.contentView.characterView.isHidden = true
        
        transitionContext.containerView.addSubview(detail.view)
        transitionContext.containerView.addSubview(image)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            image.frame.origin = CGPoint(x: detail.contentView.characterView.image.frame.origin.x,
                                         y: detail.contentView.characterView.image.frame.origin.y + contentViewY)
            detail.view.alpha = 1.0
        }, completion: { _ in
            image.removeFromSuperview()
            cell.characterView.image.isHidden = false
            detail.contentView.characterView.isHidden = false
            transitionContext.completeTransition(true)
        })
    }
}
