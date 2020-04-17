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
    @State private var showingEmptyStateView = false
    
    // Alert bindings (These have to bind back to the TabView so the alert covers the whole screen including the tab bar).
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var callToActionButton: String
    @Binding var showingCustomAlert: Bool
    
    var body: some View {
        NavigationView {
            Group {
                if showingEmptyStateView {
                    EmptyStateView(text: "No Favourites?\nAdd one on the follower screen.")
                } else {
                    List {
                        ForEach(favourites, id: \.self) { follower in
                            NavigationLink(destination: FollowerListView(username: follower.login, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, callToActionButton: self.$callToActionButton, showingCustomAlert: self.$showingCustomAlert)) {
                                FavouritesCell(follower: follower)
                            }
                        }
                        .onDelete(perform: removeFavourite)
                    }
                }
            }
            .onAppear(perform: self.retrieveFavourites)
            .navigationBarTitle("Favourites")
        }
    }
    
    func retrieveFavourites() {
        UITableView.appearance().separatorStyle = .singleLine // Hack as there's a bug where the divider lines disappear randomly
        PersistenceManager.retreiveFavourites { result in
            switch result {
            case .success(let favourites):
                if favourites.isEmpty { self.showingEmptyStateView = true }
                self.favourites = favourites
            case .failure(let error):
                print(error.rawValue)
                self.alertTitle = "Something bad happened"
                self.alertMessage = error.rawValue
                self.callToActionButton = "Ok"
                self.showingCustomAlert.toggle()
            }
        }
    }
    
    func removeFavourite(at offsets: IndexSet) {
        
        if let index = offsets.first {
            PersistenceManager.updateWith(favourite: favourites[index], actionType: .remove) { error in
                if let error = error {
                    self.alertTitle = "Bad stuff happened"
                    self.alertMessage = error.rawValue
                    self.callToActionButton = "Ok"
                    self.showingCustomAlert.toggle()
                }
            }
            favourites.remove(atOffsets: offsets)
            if favourites.isEmpty { self.showingEmptyStateView = true }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(alertTitle: .constant("Test alert"), alertMessage: .constant("Test message"), callToActionButton: .constant("Test button"), showingCustomAlert: .constant(false))
    }
}
