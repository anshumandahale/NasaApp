//
//  GridViewController.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 15/10/22.
//

import UIKit

class GridViewController<ViewModel: GridVM>: UIViewController {
    let viewModel: ViewModel
    let nib: String
    required init(viewModel: ViewModel, nib: String) {
        self.viewModel = viewModel
        self.nib = nib
        super.init(nibName: nib, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Grid"
    }
    
    func commonInit() {
        
    }
}
