//
//  ContentView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 24/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass").font(Font.system(size: 25))
                    Text("Search")
            }
            FavouritesView()
                .tabItem {
                    Image(systemName: "star.fill").font(Font.system(size: 25))
                    Text("Favourites")
            }
        }.accentColor(.green)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
