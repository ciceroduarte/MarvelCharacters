//
//  UILabelExtension.swift
//  POCView
//
//  Created by Cicero on 25/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit

extension UILabel {

    func height(forWidth width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: frame.height))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
