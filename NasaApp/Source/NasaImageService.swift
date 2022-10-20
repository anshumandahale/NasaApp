//
//  NasaImageService.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 16/10/22.
//

import Foundation
import RxSwift
import RxCocoa


protocol NasaImageServiceProtocol {
    var images: Driver<Nasa> { get }
    func getGridImages(path: String)
}

class NasaImageService: NasaImageServiceProtocol {
    var images: Driver<Nasa> {
        imagesRelay.asDriver().compactMap({$0})
    }
    private let imagesRelay = BehaviorRelay<Nasa?>(value: nil)
    func getGridImages(path: String) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let images = try JSONDecoder().decode(Nasa.self, from: data)
            if images.count > 0 {
                self.imagesRelay.accept(images)
            } else {
                self.imagesRelay.accept(nil)
            }
        } catch {
            self.imagesRelay.accept(nil)
        }
    }
}
