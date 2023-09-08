//
//  ApiGenre.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 07-09-23.
//

import Foundation
import SwiftUI

class ApiGenre {
    
    struct Genre: Identifiable {
        let id = UUID()
        let name: String
    }
}
