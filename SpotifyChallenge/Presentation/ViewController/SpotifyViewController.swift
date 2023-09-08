////
////  ContentView.swift
////  SpotifyChallenge
////
////  Created by Pichardo Perez on 06-09-23.
////
//
//import SwiftUI
//
//
////struct ContentView: View {
////
////    var body: some View {
////        TabView {
////            Text("Pestaña 1")
////                .tabItem {
////                    Image(systemName: "1.circle")
////                    Text("Pestaña 1")
////                }
////                .tag(0)
////
////            Text("Pestaña 2")
////                .tabItem {
////                    Image(systemName: "2.circle")
////                    Text("Pestaña 2")
////                }
////                .tag(1)
////        }
////        .accentColor(.blue) // Cambia el color de la pestaña seleccionada
////    }
////}
//
//struct ContentView: View {
//    var body: some View{
//        TabView{
//            Text("Pestana1")
//                .padding()
//                .tabItem{
//                    Image(systemName: "house")
//                }
//            Text("Pestaña2")
//                .tabItem{
//                    Image(systemName: "person")
//                }
//        }
//        .accentColor(.green)
//    }
//}
//struct ContentView_Previews: PreviewProvider{
//    static var previews: some View{
//        ContentView()
//    }
//}
//
//class SpotifyViewController: UIViewController {
//
//    var viewModel = SpotifyViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.onViewDidLoad()
//        setupUI()
//    }
//
//    func setupUI() {
//        view.backgroundColor = .blue
//        let contentView = UIHostingController(rootView: ContentView())
//        addChild(contentView)
//        contentView.view.frame = view.bounds
//        view.addSubview(contentView.view)
//        contentView.didMove(toParent: self)
//    }
//}
import SwiftUI

//struct ContentView: View {
//
//    var body: some View{
//        TabView{
//            Text("Pestana1")
//                .padding()
//                .tabItem{
//                    Image(systemName: "house")
//                }
//            Text("Pestaña2")
//                .tabItem{
//                    Image(systemName: "person")
//                }
//        }
//        .accentColor(.green)
//    }
//}
//struct ContentView: View {
//    @State private var songs: [ApiNewRelease.Album] = []
//
//    var body: some View {
//        TabView {
//            Text("Pestaña 1")
//                .padding()
//                .tabItem {
//                    Image(systemName: "house")
//                }
//
//            Text("Pestaña 2")
//                .tabItem {
//                    Image(systemName: "person")
//                }
//
//            // Esta es la tercera pestaña con una lista
//            ThirdTabView()
//                .tabItem {
//                    Image(systemName: "list.bullet")
//                    Text("Tabla")
//                }
//        }
//        .accentColor(.green)
//    }
//}
//
//struct ThirdTabView: View {
//    var viewModel = SpotifyViewModel()
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(0..<10) { index in
//                    Text("Elemento \(index)")
//                }
//            }
//            .navigationTitle("Tabla en Pestaña")
//            .onAppear(){
//                viewModel.getNewReleases()
//            }
//        }
//    }
//}

struct ContentView: View {
    @State private var songs: [ApiNewRelease.Items] = [] // Cambié el tipo de songs a [Items]

    var body: some View {
        TabView {
            Text("Pestaña 1")
                .padding()
                .tabItem {
                    Image(systemName: "house")
                }
            
            Text("Pestaña 2")
                .tabItem {
                    Image(systemName: "person")
                }
            
            // Esta es la tercera pestaña con una lista
            ThirdTabView(songs: $songs) // Pasa songs como un binding
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tabla")
                }
        }
        .accentColor(.green)
    }
}

struct ThirdTabView: View {
    @Binding var songs: [ApiNewRelease.Items] // Recibe songs como un binding
    var viewModel = SpotifyViewModel()

    var body: some View {
        NavigationView {
            List(songs, id: \.name) { item in
                NavigationLink(destination: Text("Detalle del álbum: \(item.name)")) {
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

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
//class SpotifyViewController: UIViewController {
//
//    var viewModel = SpotifyViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.onViewDidLoad()
//        setupUI()
//    }
//
//    func setupUI() {
//        view.backgroundColor = .blue
//
//    }
//}
