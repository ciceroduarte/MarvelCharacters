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
        detail.view.frame = transitionContext.finalFrame(for: detail)
        detail.view.alpha = 0.0
        detail.contentView.layoutIfNeeded()

        transitionContext.containerView.addSubview(detail.view)

        guard let index = home.lastSelectedIndexPath,
            let cell = collectionView.cellForItem(at: index) as? CharacterCell,
            let attributes = collectionView.layoutAttributesForItem(at: index) else {
                animate(destinationView: detail.view, transitionContext: transitionContext)
                return
        }

        let image = imageView(fromCharacterCell: cell)

        let cellOrigin = collectionView.convert(attributes.frame.origin, to: nil)
        let contentViewY = detail.contentView.frame.origin.y

        image.frame.origin = CGPoint(x: image.frame.origin.x + cellOrigin.x,
                                     y: image.frame.origin.y + cellOrigin.y)
        
        cell.characterView.image.isHidden = true
        detail.contentView.characterView.isHidden = true

        transitionContext.containerView.addSubview(image)

        let destination = CGPoint(x: detail.contentView.characterView.image.frame.origin.x,
                                  y: detail.contentView.characterView.image.frame.origin.y + contentViewY)

        animate(image,
                toPoint: destination,
                destinationView: detail.view,
                transitionContext: transitionContext,
                completion: {
                    cell.characterView.image.isHidden = false
                    detail.contentView.characterView.isHidden = false
        })
    }
}
