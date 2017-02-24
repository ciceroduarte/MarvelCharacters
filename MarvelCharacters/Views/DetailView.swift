//
//  DetailView.swift
//  POCView
//
//  Created by Cicero on 30/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    let scrollView: UIScrollView
    let contentView: UIView
    let image: UIImageView
    let name: UILabel
    
    init() {
        scrollView = UIScrollView()
        contentView = UIView()
        
        image = UIImageView()
        name = UILabel()
        
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(image)
        contentView.addSubview(name)
        
        self.backgroundColor = .red
        
        name.numberOfLines = 0
        name.textColor = .white
        
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(150)
        }
        
        name.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Layout.margin)
            make.top.equalTo(image.snp.bottom).offset(Layout.margin)
        }
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(name.snp.bottom)
        }
    }
}
