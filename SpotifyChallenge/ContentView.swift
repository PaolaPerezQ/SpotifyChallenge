//
//  ContentView.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 06-09-23.
//

import Alamofire
import SwiftyJSON

class ContentView: UIViewController {
    
    var accessToken: String?
    let artistID = "0TnOYISbd1XYRBk9myaseg"
    var client_id = "e57cca2f1c6f4fdc94cac9c9eb0f1754"
    var redirect_uri = "spotifychallenge://callback"
    let client_secret = "4c2d7e09cd8845cfaf5df7db1e51dd5a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getClientCredentialsToken { accessToken in
            if let token = accessToken {
                print("Token de acceso: \(token)")
            } else {
                print("No se pudo obtener el token de acceso")
            }
        }
        getArtistInfo(artistID: artistID)
        getAvailableGenres()
        getNewReleases()

    }
    
    


    func getClientCredentialsToken(completion: @escaping (String?) -> Void) {
        let clientID = "e57cca2f1c6f4fdc94cac9c9eb0f1754"
        let clientSecret = "4c2d7e09cd8845cfaf5df7db1e51dd5a"
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic " + (clientID + ":" + clientSecret).data(using: .utf8)!.base64EncodedString(),
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = ["grant_type": "client_credentials"]
        
        AF.request("https://accounts.spotify.com/api/token", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let tokenInfo = value as? [String: Any], let accessToken = tokenInfo["access_token"] as? String {
                        completion(accessToken)
                    } else {
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error obteniendo el token de acceso: \(error)")
                    completion(nil)
                }
            }
    }
    

    func getNewReleases() {
        let endpoint = "https://api.spotify.com/v1/browse/new-releases"
print(endpoint)
        getClientCredentialsToken { obtainedToken in
            if let token = obtainedToken {
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(token)"
                ]
                
                AF.request(endpoint, headers: headers).responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        
                        // Procesa la respuesta JSON según tus necesidades
                        print(json)
                        
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
        let endpoint = "https://api.spotify.com/v1/recommendations/available-genre-seeds"
        print(endpoint)

        getClientCredentialsToken { obtainedToken in
            if let token = obtainedToken {
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(token)"
                ]
                
                // Realiza la solicitud HTTP GET con el token de acceso
                AF.request(endpoint, headers: headers).responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        
                        // Procesa la respuesta JSON según tus necesidades
                        print(json)
                        
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            } else {
                print("No se pudo obtener el token de acceso")
            }
        }
    }

    func getArtistInfo(artistID: String) {
        var accessToken: String?

        // Función para obtener el token de acceso
        func getTokenAndFetchArtistInfo() {
            let url = "https://api.spotify.com/v1/artists/\(artistID)"
            print(url)

            let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken ?? "")"]

            AF.request(url, method: .get, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let artistInfo = value as? [String: Any] {
                            // Aquí puedes procesar la información del artista obtenida
                            print(artistInfo)
                        }
                    case .failure(let error):
                        print("Error al obtener información del artista: \(error)")
                    }
                }
        }

        getClientCredentialsToken { obtainedToken in
            if let token = obtainedToken {
                accessToken = token
                getTokenAndFetchArtistInfo()
            } else {
                print("No se pudo obtener el token de acceso")
            }
        }
    }
}
