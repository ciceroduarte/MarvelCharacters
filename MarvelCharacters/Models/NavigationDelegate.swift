//
//  NavigationDelegate.swift
//  MarvelCharacters
//
//  Created by Cicero on 25/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

class NavigationDelegate: NSObject, UINavigationControllerDelegate {

    let transitionController: TransitionController

    init(withTransitionController transitionController: TransitionController = TransitionController()) {
        self.transitionController = transitionController
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionController
    }
}
