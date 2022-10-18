//
//  NasaImage.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 16/10/22.
//

import Foundation

enum MediaType: String, Codable {
    case image = "image"
}

struct NasaImage: Codable {
    let copyright: String?
    let date, explanation: String
    let hdurl: String
    let mediaType: MediaType
    let serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}

typealias Nasa = [NasaImage]
