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
    var images: BehaviorSubject<Nasa> { get }
    func getGridImages(path: String)
}

class NasaImageService: NasaImageServiceProtocol {
    var images = BehaviorSubject<Nasa>(value: [])
    func getGridImages(path: String) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let images = try JSONDecoder().decode(Nasa.self, from: data)
            self.images.onNext(images)
        } catch {
            print("Error Exception: \(error)")
            self.images.onError(error)
        }
    }
}
