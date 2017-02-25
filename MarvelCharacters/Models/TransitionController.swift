//
//  TransitionController.swift
//  MarvelCharacters
//
//  Created by Cicero on 25/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

class TransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
