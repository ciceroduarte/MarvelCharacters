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
}
