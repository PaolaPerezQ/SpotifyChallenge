//
//  ApiNewRelease.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 07-09-23.
//

import Foundation
import SwiftUI
    
//    struct Album: Codable {
//        let albums: Albums
//
//    }
//    struct Albums: Codable {
//        let items: [Items]
//    }
//    struct Items: Codable {
//        let images: [Imagen]
//        let name: String
//        let type: String
//        let external_urls: String
//        let artists: [Artist]
//    }
//    struct Imagen: Codable {
//        let url: String
//    }
//    struct Artist: Codable {
//        let type: String
//        let name: String
//        let id: String
//    }

//struct Album: Codable {
//    let albums: Albums
//}
//
//struct Albums: Codable {
//    let items: [AlbumItem]
//}
//
//struct AlbumItem: Codable {
//    let external_urls: ExternalURLs
//    let name: String
//    let type: String
//    let artists: [Artist]
//    let images: [Image]
//}
//
//struct ExternalURLs: Codable {
//    let spotify: String
//}
//
//struct Artist: Codable {
//    let type: String
//    let name: String
//    let id: String
//}
//
//struct Image: Codable {
//    let url: String
//}

struct SpotifyResponse: Codable {
    let albums: Albums
}

struct Albums: Codable {
    let items: [AlbumItem]
}

struct AlbumItem: Codable {
    let external_urls: ExternalURLs
    let name: String
    let type: String
    let artists: [Artist]
    let images: [Image]
}

struct ExternalURLs: Codable {
    let spotify: String
}

struct Artist: Codable {
    let type: String
    let name: String
    let id: String
}

struct Image: Codable {
    let url: String
}
