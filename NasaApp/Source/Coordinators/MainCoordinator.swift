//
//  MainCoordinator.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 15/10/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imageService = NasaImageService()
        let gridVC = GridViewController.init(viewModel: GridViewModel(router: self, imageService: imageService), nib: R.nib.gridViewController.name)
        navigationController.pushViewController(gridVC, animated: true)
    }
}
