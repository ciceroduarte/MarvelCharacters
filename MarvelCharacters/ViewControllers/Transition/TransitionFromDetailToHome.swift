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
        let image = UIImageView(frame: CGRect.zero)
        image.image = cell.characterView.image.image
        image.frame = cell.characterView.image.frame
        image.layer.cornerRadius = cell.characterView.image.layer.cornerRadius
        image.layer.borderWidth = cell.characterView.image.layer.borderWidth
        image.layer.borderColor = cell.characterView.image.layer.borderColor
        image.clipsToBounds = true
        image.backgroundColor = .clear
        
        let originalFrame = CGRect(x: detail.contentView.characterView.image.frame.origin.x,
                                   y: detail.contentView.characterView.image.frame.origin.y + 64,
                                   width: detail.contentView.characterView.image.frame.size.width,
                                   height: detail.contentView.characterView.image.frame.size.height)
        
        image.frame = originalFrame
        
        detail.contentView.characterView.image.isHidden = true
        cell.characterView.image.isHidden = true
        collectionView.isHidden = false
        
        transitionContext.containerView.addSubview(image)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            image.frame = CGRect(x: cellFrame.origin.x + cell.characterView.image.frame.origin.x,
                                         y: cellFrame.origin.y + cell.characterView.image.frame.origin.y + 64,
                                         width: detail.contentView.characterView.image.frame.size.width,
                                         height: detail.contentView.characterView.image.frame.size.height)
            home.view.alpha = 1.0
        }, completion: { _ in
            image.removeFromSuperview()
            cell.characterView.image.isHidden = false
            
            transitionContext.completeTransition(true)
        })
    }
}
