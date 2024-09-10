//
//  ContentView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 17/7/2567 BE.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { router in
                    SpotifyHomeView()
                }
            }
            
            Button("Open Bumble") {
                router.showScreen(.fullScreenCover) { router in
                    BumbleHomeView()
                }
            }
            
            Button("Open Netflix") {
                router.showScreen(.fullScreenCover) { router in
                    NetflixHomeView()
                }
            }
        }
    }
    
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
