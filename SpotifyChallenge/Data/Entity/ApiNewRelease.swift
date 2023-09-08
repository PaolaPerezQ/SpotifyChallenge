//
//  ApiNewRelease.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 07-09-23.
//

import Foundation
import SwiftUI

class ApiNewRelease {
    
    struct Album: Codable {
        let albums: Albums

    }
    struct Albums: Codable {
        let items: [Items]
    }
    struct Items: Codable {
        let images: [Image]
        let name: String
        let type: String
        let external_urls: String
        let artists: [Artist]
    }
    struct Image: Codable {
        let url: String
    }
    struct Artist: Codable {
        let type: String
        let name: String
        let id: String
    }
}
