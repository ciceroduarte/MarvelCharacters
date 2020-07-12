//
//  TransitionController.swift
//  MarvelCharacters
//
//  Created by Cicero on 25/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

typealias Transition = UITransitionContextViewControllerKey

class TransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let detail = transitionContext.viewController(forKey: Transition.to) as? DetailViewController,
            let home = transitionContext.viewController(forKey: Transition.from) as? HomeViewController {
            from(home, toDetail: detail, with: transitionContext)
        } else if let detail = transitionContext.viewController(forKey: Transition.from) as? DetailViewController,
            let home = transitionContext.viewController(forKey: Transition.to) as? HomeViewController {
            from(detail, toHome: home, with: transitionContext)
        }
    }

    func imageView(fromCharacterCell cell: CharacterCell) -> UIImageView {
        let image = UIImageView(frame: .zero)

        image.image = cell.characterView.image.image
        image.frame = cell.characterView.image.frame
        image.layer.cornerRadius = cell.characterView.image.layer.cornerRadius
        image.layer.borderWidth = cell.characterView.image.layer.borderWidth
        image.layer.borderColor = cell.characterView.image.layer.borderColor
        image.clipsToBounds = cell.characterView.image.clipsToBounds
        image.backgroundColor = cell.characterView.image.backgroundColor

        return image
    }

    func animate(_ view: UIView? = nil,
                 toPoint point: CGPoint = .zero,
                 destinationView: UIView,
                 transitionContext: UIViewControllerContextTransitioning,
                 completion: (() -> Void)? = nil) {

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            view?.frame.origin = CGPoint(x: point.x, y: point.y)
            destinationView.alpha = 1.0
        }, completion: { _ in
            view?.removeFromSuperview()
            completion?()
            transitionContext.completeTransition(true)
        })
    }
}
