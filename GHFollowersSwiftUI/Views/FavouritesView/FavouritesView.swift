//
//  FavouritesView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 24/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct FavouritesView: View {
    
    @State private var favourites = [Follower]()
    
    var body: some View {
        NavigationView {
            List(favourites, id: \.self) { follower in
                Text(follower.login)
            }
            .onAppear(perform: self.retrieveFavourites)
            .navigationBarTitle("Favourites")
        }
    }
    
    func retrieveFavourites() {
        PersistenceManager.retreiveFavourites { result in
            switch result {
            case .success(let favourites):
                self.favourites = favourites
            case .failure(let error):
                // add error handling
                print(error.rawValue)
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
