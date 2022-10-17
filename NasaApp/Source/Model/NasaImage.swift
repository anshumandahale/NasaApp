//
//  NasaImage.swift
//  NasaApp
//
//  Created by Anshuman Dahale on 16/10/22.
//

import Foundation

enum MediaType: Codable {
    case image
}

struct NasaImage: Codable {
    let copyright: String
    let date: Date
    let explanation: String
    let hdurl: URL
    let media_type: MediaType
    let service_version: String
    let title: String
    let url: URL
}

//struct NASAElement: Codable {
//    let copyright, date, explanation: String
//    let hdurl: String
//    let mediaType, serviceVersion, title: String
//    let url: String
//
//    enum CodingKeys: String, CodingKey {
//        case copyright, date, explanation, hdurl
//        case mediaType = "media_type"
//        case serviceVersion = "service_version"
//        case title, url
//    }
//}

typealias Nasa = [NasaImage]
