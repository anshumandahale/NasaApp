//
//  MockMainRoutable.swift
//  NasaAppTests
//
//  Created by Anshuman Dahale on 21/10/22.
//

import Foundation
@testable import NasaApp

class MockMainRouter: MainRoutable {
    
    var calledRoute: CalledRoute?
    func showDetails(image: NasaImage) {
        calledRoute = .detailView
    }
    
    enum CalledRoute {
        case detailView
        case backToBase
    }
}
