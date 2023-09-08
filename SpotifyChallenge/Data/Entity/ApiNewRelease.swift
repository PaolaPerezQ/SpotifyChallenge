//
//  ApiNewRelease.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 07-09-23.
//

import Foundation
import SwiftUI
    
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
