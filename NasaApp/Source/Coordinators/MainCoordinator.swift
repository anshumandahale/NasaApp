//
//  MainCoordinator.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 15/10/22.
//

import Foundation
import UIKit

protocol MainRoutable {
    func showDetails(images: Nasa, selectedImageIndex: Int)
}

class MainCoordinator: NSObject, Coordinator, MainRoutable {
    
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
    
    func showDetails(images: Nasa, selectedImageIndex: Int) {
        let detailVC = DetailViewController.init(viewModel: DetailViewModel(router: self, images: images, selectedImageIndex: selectedImageIndex), nib: R.nib.detailViewController.name)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func popToGridVC() {
        navigationController.popToRootViewController(animated: true)
    }
}
