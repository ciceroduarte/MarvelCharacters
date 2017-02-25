//
//  DetailViewController.swift
//  POCView
//
//  Created by Cicero on 30/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    let detailViewModel: DetailViewModel
    
    var contentView: DetailView {
        guard let detailView = view as? DetailView else {
            fatalError("Invalid DetailView")
        }
        return detailView
    }
    
    init(withViewModel detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
        
        contentView.name.text = detailViewModel.characterName()
        contentView.image.kf.setImage(with: detailViewModel.characterImage())
    }
}
