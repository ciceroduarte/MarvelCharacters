//
//  UIViewExtension.swift
//  POCView
//
//  Created by Cicero on 22/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(views : [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
