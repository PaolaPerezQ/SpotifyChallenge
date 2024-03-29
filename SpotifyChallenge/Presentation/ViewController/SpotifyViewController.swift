//
//  ContentView.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 06-09-23.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SpotifyViewModel()

    var body: some View {
        TabView {
            FirstTabView(newReleases: viewModel.songs)
                .tabItem {
                    Label("Nuevos release", systemImage: "list.bullet")
                }
            SecundTabView(genres: viewModel.genres)
                .tabItem {
                    Label("Lista de generos", systemImage: "list.bullet")
                }
        }
        .accentColor(.green)
    }
}

struct FirstTabView: View {
    @StateObject var viewModel = SpotifyViewModel()

    let newReleases: [AlbumItem]
    
    var body: some View {
        NavigationView {
            List(viewModel.songs, id: \.name) { item in
                NavigationLink(destination: ArtistDetailView(artistID: item.artists.first?.id)) {
                    HStack {
                        if let imageURL = URL(string: item.images.first?.url ?? "") {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(width: 40, height: 40)
                            } placeholder: {
                                ProgressView()
                            }
                        }

                        Text("Álbum: \(item.name)")
                            .font(.subheadline)
                            .frame(alignment: .center)
                        Spacer()
                        Text("Artista: \(item.artists[0].name)")
                            .frame(alignment: .center)
                            .foregroundColor(.green)
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitle("Nuevos Lanzamientos")
            .onAppear(){
                viewModel.getNewReleases()
            }
        }
    }
}

struct ArtistDetailView: View {
    let artistID: String?
    @StateObject var viewModel = SpotifyViewModel()

    var body: some View {
        VStack {
            if let artist = viewModel.artistInfo {
                if let imageURL = URL(string: artist.images.first?.url ?? "") {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 200, height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text("Artista: \(artist.name)")
                    .font(.title2)
                    .padding()
                
                Text("Géneros: \(artist.genres.joined(separator: ", "))")
                    .font(.title3)
                
                Text("Popularidad: \(artist.popularity)")
                    .font(.title3)
                Text("followers: \(artist.followers.total)")
                    .font(.title3)
            } else {
                Text("Cargando información del artista...")
                    .font(.title)
            }
        }
        .onAppear {
            if let artistID = artistID {
                viewModel.getArtistInfo(artistID: artistID)
            }
        }
    }
}

struct SecundTabView: View {
    @StateObject var viewModel = SpotifyViewModel()
    
    let genres: [String]

       init(genres: [String]) {
           self.genres = genres
       }
        var body: some View {
            NavigationView {
                List(viewModel.genres, id: \.self) { genre in
                    Text(genre)
                }
                .navigationBarTitle("Géneros Disponibles")
                .onAppear() {
                    viewModel.getAvailableGenres() 
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
