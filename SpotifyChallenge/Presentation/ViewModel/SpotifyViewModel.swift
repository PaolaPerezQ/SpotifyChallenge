//
//  TokenSpotify.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 06-09-23.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

class SpotifyViewModel: ObservableObject {
     //MARK: variables
    private var accessToken: String?
    let accessTokenHeader: HTTPHeaders
    var jsonDecoder: JSON?
    @Published var songs: [AlbumItem] = []
    @Published var genres: [String] = []
    


    enum Constants {
        enum Url {
            static let urlToken = "https://accounts.spotify.com/api/token"
            static let urlNewReleases = "https://api.spotify.com/v1/browse/new-releases"
            static let urlAvalibleGenreSeeds = "https://api.spotify.com/v1/recommendations/available-genre-seeds"
            static let artistID = "0TnOYISbd1XYRBk9myaseg"
            static let urlArtist = "https://api.spotify.com/v1/artists/\(artistID)"

        }
        enum ClientSpotify{
            static let clientSecret = "4c2d7e09cd8845cfaf5df7db1e51dd5a"
            static let clientID = "e57cca2f1c6f4fdc94cac9c9eb0f1754"
        }
        enum Token {
            static let accessTokenString = "access_token"
            static let parameters = ["grant_type": "client_credentials"]
            static let authorization = "Authorization"
            static let basic = "Basic "
            static let colon = ":"
            static let contenType = "Content-Type"
            static let contenTypeUrl = "application/x-www-form-urlencoded"
            static let errorToken = "Error obteniendo el token de acceso:"
        }
    }
    
    struct TokenResponse: Codable {
        let access_token: String
    }
    init() {
        self.accessTokenHeader = ["Authorization": "Bearer \(String(describing: self.accessToken))"]
    }
    
    func onViewDidLoad() {
        getClientCredentialsToken { accessToken in
         
        }
        getArtistInfo(artistID: Constants.Url.artistID)
        getAvailableGenres()
        getNewReleases()
    }
    // MARK: token
    func getClientCredentialsToken(completion: @escaping (String?) -> Void) -> String? {
            
            let headers: HTTPHeaders = [
                Constants.Token.authorization:Constants.Token.basic + (Constants.ClientSpotify.clientID + Constants.Token.colon + Constants.ClientSpotify.clientSecret).data(using: .utf8)!.base64EncodedString(),
                Constants.Token.contenType:Constants.Token.contenTypeUrl
            ]
                        
        AF.request(Constants.Url.urlToken,
                   method: .post,
                   parameters: Constants.Token.parameters,
                   encoding: URLEncoding.default,
                   headers: headers)
        .responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
                 case .success(let tokenResponse):
                     completion(tokenResponse.access_token)
                self.accessToken = tokenResponse.access_token
                print("new \(String(describing: self.accessToken))")
                 case .failure(let error):
                print(" \(Constants.Token.errorToken) \(error)")
                     completion(nil)
                 }
             }
        return accessToken
        print("url= accessTokenHeader1\(self.accessTokenHeader)")

        }
    // MARK: conextion

    func getNewReleases() {
        @State var songs: [AlbumItem] = []

        print(Constants.Url.urlNewReleases)
        getClientCredentialsToken { obtainedToken in
            if let token = obtainedToken {
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(token)"
                ]

                AF.request(Constants.Url.urlNewReleases, headers: headers).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let spotifyResponse = try decoder.decode(SpotifyResponse.self, from: data)
                            // Actualiza la vista con los nuevos lanzamientos
                            self.songs = spotifyResponse.albums.items
                            print("url= new-releases\(spotifyResponse)")

                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            } else {
                print("No se pudo obtener el token de acceso")
            }
        }
    }
    
    func getAvailableGenres() {
        @State var genres: [String] = []
        
        print(Constants.Url.urlAvalibleGenreSeeds)
        
        getClientCredentialsToken { obtainedToken in
            if let token = obtainedToken {
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(token)"
                ]
                
                AF.request(Constants.Url.urlAvalibleGenreSeeds, headers: headers).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let genresResponse = try decoder.decode(Genre.self, from: data)
                            // Ordena los géneros alfabéticamente
                            let sortedGenres = genresResponse.genres.sorted()
                            DispatchQueue.main.async { // Asegura que la actualización ocurra en el hilo principal
                                self.genres = sortedGenres // Actualiza la propiedad de géneros
                            }
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
    

    func getArtistInfo(artistID: String) {

    AF.request(Constants.Url.urlArtist, method: .get, headers: self.accessTokenHeader).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let artistInfo = value as? [String: Any] {
                    print("url= artists \(artistInfo)")
                }
            case .failure(let error):
                print("Error al obtener información del artista: \(error)")
            }
        }
    }
}
