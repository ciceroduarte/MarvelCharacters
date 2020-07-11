//
//  UIImageViewExtension.swift
//  MarvelCharacters
//
//  Created by Cícero Duarte da Silva on 11/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?) {
        kf.setImage(with: url)
    }
}
