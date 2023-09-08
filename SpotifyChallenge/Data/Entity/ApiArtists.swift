//
//  Endpoint.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 06-09-23.
//

import Foundation
import SwiftUI

struct ApiArtists: Codable {
    let id = UUID()
    let name: String
    let followers: Int
    let artistImageUrl: String
    let genres: [String]
    let spotifyUrl: String
}

