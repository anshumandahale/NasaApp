//
//  NasaImageService.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 16/10/22.
//

import Foundation

protocol NasaImageServiceProtocol {
    func getGridImages(path: String)
}

class NasaImageService: NasaImageServiceProtocol {
    func getGridImages(path: String) {
//        let dataURL = URL(fileURLWithPath: path)
        guard let fileString = try? String(contentsOfFile: path) else { return }
        guard let jsonData = try? fileString.data(using: .utf8) else { return }
        let images = try? JSONDecoder().decode(Nasa.self, from: jsonData)
        print(images)
    }
}
