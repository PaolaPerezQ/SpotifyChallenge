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
                    Label("Tabla", systemImage: "list.bullet")
                }
            SecundTabView(genres: viewModel.genres)
                .tabItem {
                    Label("Tabla", systemImage: "list.bullet")
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
                NavigationLink(destination: Text("Detalle del artista: \(item.artists[0].name)")) {
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("Artista: \(item.artists[0].name)")
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
                    viewModel.getAvailableGenres() // Llama a la función para obtener los géneros
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
