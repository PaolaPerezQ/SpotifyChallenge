//
//  SpotifyChallengeApp.swift
//  SpotifyChallenge
//
//  Created by Pichardo Perez on 06-09-23.
//

import SwiftUI

//struct ContentViewWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> ContentView {
//        return ContentView()
//    }
//
//    func updateUIViewController(_ uiViewController: ContentView, context: Context) {
//        //
//    }
//}

//struct ContentViewWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> SpotifyViewController {
//        return SpotifyViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: SpotifyViewController, context: Context) {
//        //
//    }
//}
@main
struct SpotifyChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
//            ContentViewWrapper()
            
        }
    }
}
