//
//  UICollectionViewExtension.swift
//  POCView
//
//  Created by Cicero on 23/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UIView>(_: T.Type, forSuplementaryViewOfKind kind: String) where T: Reusable {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UIView>(ofKind elementKind: String,
                                          forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(ofKind: elementKind,
                                                          withReuseIdentifier: T.reuseIdentifier,
                                                          for: indexPath) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
    
}
