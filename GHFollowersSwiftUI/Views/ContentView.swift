//
//  ContentView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 24/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var callToActionButton = ""
        
    var body: some View {
        ZStack {
            TabView {
                SearchView(alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, callToActionButton: self.$callToActionButton, showingCustomAlert: self.$showingAlert)
                    .tabItem {
                        SFSymbols.magnifyingglass.font(Font.system(size: 25))
                        Text("Search")
                }
                FavouritesView(alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, callToActionButton: self.$callToActionButton, showingCustomAlert: self.$showingAlert)
                    .tabItem {
                        SFSymbols.starfill.font(Font.system(size: 25))
                        Text("Favourites")
                }
            }
            .accentColor(.green)
            if showingAlert {
                CustomAlertView(titleLabel: self.alertTitle, bodyLabel: self.alertMessage, callToActionButton: self.callToActionButton, showingModal: self.$showingAlert)
            }
        }
            
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
