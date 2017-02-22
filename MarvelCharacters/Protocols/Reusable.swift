//
//  ReusableView.swift
//  MarvelHeroes
//
//  Created by Cicero on 21/06/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit

protocol Reusable: class {}

extension Reusable where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
