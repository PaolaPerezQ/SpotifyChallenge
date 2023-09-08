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

class SpotifyViewModel {
     //MARK: variables
    private var accessToken: String?
    let accessTokenHeader: HTTPHeaders
    var jsonDecoder: JSON?

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
    
//    let url = "https://rickandmortyapi.com/api/character"
//
//        if let urlS = URL(string: url) {
//        if let data = try? Data(contentsOf: urlS){
//            let decodificador = JSONDecoder()
//
//            if let datosDecofic = try? decodificador.decode(Resultst.self, from: data) {
//                print("datosDecodificados: \(datosDecofic.results) ")
//
//                resultss = datosDecofic.results
//
//                tablaRM.reloadData()
//            }
//        }
//    }
//
    func getNewReleases() {
           print(Constants.Url.urlNewReleases)
           getClientCredentialsToken { obtainedToken in
               if let token = obtainedToken {
                   let headers: HTTPHeaders = [
                       "Authorization": "Bearer \(token)"
                   ]

                   AF.request(Constants.Url.urlNewReleases, headers: headers).responseJSON { response in
                       switch response.result {
                       case .success(let data):
                           let json = JSON(data)
                           print("url= new-releases\(json)")

//                           if let dataJson = try? Data(from: json.debugDescription as! Decoder){
//                               let decoder = JSONDecoder()
//                               if let dataDecoder = try? decoder.decode(ApiNewRelease.Album.self, from: json.rawData()){
//                                   print(" decoficador \( dataDecoder)")
//                               }
                          
                                   let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                                   let decoder = JSONDecoder()
                                   let albumData = try decoder.decode(ApiNewRelease.Album.self, from: jsonData)
                                   // Llamar a una función para mostrar los datos en la vista
                              
	
                           self.jsonDecoder = json


                       case .failure(let error):
                           print("Error: \(error)")
                       }
                   }
               } else {
                   print("No se pudo obtener el token de acceso")
               }
           }
       }
    
//    func getNewReleases() {
//    print(Constants.Url.urlNewReleases)
//    getClientCredentialsToken { obtainedToken in
//        if let token = obtainedToken {
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer \(token)"
//            ]
//
//            AF.request(Constants.Url.urlNewReleases, headers: headers).responseJSON { response in
//                switch response.result {
//                case .success(let data):
//                    if let json = data as? [String: Any] {
//                        do {
//                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//                            let decoder = JSONDecoder()
//                            let albumData = try decoder.decode(ApiNewRelease.Album.self, from: jsonData)
//                            // Llamar a una función para mostrar los datos en la vista
//                            self.displayNewReleases(albumData.albums.items)
//                        } catch {
//                            print("Error decoding JSON: \(error)")
//                        }
//                    } else {
//                        print("Error: No se pudo convertir la respuesta a JSON")
//                    }
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//        } else {
//            print("No se pudo obtener el token de acceso")
//        }
//    }
//}

    func displayNewReleases(_ newReleases: [ApiNewRelease.Items]) {
        NavigationView {
            List(newReleases, id: \.name) { item in
                NavigationLink(destination: Text("Detalle del álbum: \(item.name)")) {
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("Artista: \(item.artists[0].name)")
                    }
                }
            }
            .navigationBarTitle("Nuevos Lanzamientos")
        }
    }


    
    func getAvailableGenres() {
          print(Constants.Url.urlAvalibleGenreSeeds)
  
          getClientCredentialsToken { obtainedToken in
              if let token = obtainedToken {
                  let headers: HTTPHeaders = [
                      "Authorization": "Bearer \(token)"
                  ]
  
                  AF.request(Constants.Url.urlAvalibleGenreSeeds, headers: headers).responseJSON { response in
                      switch response.result {
                      case .success(let data):
                          let json = JSON(data)
  
                    print("url= available-genre-seeds \(json)")

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
