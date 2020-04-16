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
    
    // Alert bindings
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var callToActionButton: String
    @Binding var showingCustomAlert: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(favourites, id: \.self) { follower in
                        NavigationLink(destination: FollowerListView(username: follower.login, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, callToActionButton: self.$callToActionButton, showingCustomAlert: self.$showingCustomAlert)) {
                            FavouritesCell(follower: follower)
                        }
                    }
                    .onDelete(perform: removeFavourite)
                }
                .onAppear(perform: self.retrieveFavourites)
                .navigationBarTitle("Favourites")
            }
        }
    }
    
    func retrieveFavourites() {
        PersistenceManager.retreiveFavourites { result in
            switch result {
            case .success(let favourites):
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
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(alertTitle: .constant("Test alert"), alertMessage: .constant("Test message"), callToActionButton: .constant("Test button"), showingCustomAlert: .constant(false))
    }
}
