//
//  LoadingView.swift
//  MarvelCharacters
//
//  Created by Cicero on 26/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView
    
    init() {
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func setupViews() {
        addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        activityIndicatorView.active([
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func show() {
        isHidden = false
        activityIndicatorView.startAnimating()
        
    }
    
    func hide() {
        isHidden = true
        activityIndicatorView.stopAnimating()
    }
}
