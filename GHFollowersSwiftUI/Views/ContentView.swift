//
//  ContentView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 24/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userName = ""
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
            FavouritesView()
                .tabItem {
                    Image(systemName: "star")
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
