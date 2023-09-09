//
//  Endpoint.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 06-09-23.
//

import Foundation
import SwiftUI

struct SpotifyArtist: Codable {
    let href: String
    let genres: [String]
    let external_urls: ExternalURLs
    let images: [Image]
    let popularity: Int
    let uri: String
    let name: String
    let id: String
    let followers: Followers
    let type: String

    struct ExternalURLs: Codable {
        let spotify: String
    }

    struct Image: Codable {
        let height: Int
        let url: String
        let width: Int
    }

    struct Followers: Codable {
        let href: String?
        let total: Int
    }
}

