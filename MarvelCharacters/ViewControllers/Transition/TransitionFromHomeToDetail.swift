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
        let image = UIImageView(frame: CGRect.zero)
        image.image = cell.characterView.image.image
        image.frame = cell.characterView.image.frame
        image.layer.cornerRadius = cell.characterView.image.layer.cornerRadius
        image.layer.borderWidth = cell.characterView.image.layer.borderWidth
        image.layer.borderColor = cell.characterView.image.layer.borderColor
        image.clipsToBounds = true
        image.backgroundColor = .clear

        let navigationBarHeight = detail.navigationController?.navigationBar.frame.height ?? 0.0
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + navigationBarHeight

        let originalFrame = CGRect(x: image.frame.origin.x + cellFrame.origin.x,
                                   y: image.frame.origin.y + cellFrame.origin.y + topBarHeight,
                                   width: image.frame.size.width,
                                   height: image.frame.size.height)
        
        image.frame = originalFrame
        
        cell.characterView.image.isHidden = true
        detail.contentView.characterView.isHidden = true
        
        transitionContext.containerView.addSubview(detail.view)
        transitionContext.containerView.addSubview(image)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            image.frame = CGRect(origin:
                CGPoint(x: detail.contentView.characterView.image.frame.origin.x,
                        y: detail.contentView.characterView.image.frame.origin.y + topBarHeight),
                        size: image.frame.size)
            
            detail.view.alpha = 1.0
        }, completion: { _ in
            image.removeFromSuperview()
            cell.characterView.image.isHidden = false
            detail.contentView.characterView.isHidden = false
            transitionContext.completeTransition(true)
        })
    }
    
}
