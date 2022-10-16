//
//  Coordinator.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 15/10/22.
//

import UIKit
import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}


