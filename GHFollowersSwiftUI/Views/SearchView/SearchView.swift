//
//  SearchView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 24/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @State private var username = ""
    @State private var action: Int? = 0
    
    var getFollowersButtonDisabled: Bool {
        return username.isEmpty
    }
    
    // Alert bindings. They're not set on this screen but need to be passed to the FollowerListView so if an alert appears is covers the whole TabView rather than just the FollowerListView.
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var callToActionButton: String
    @Binding var showingCustomAlert: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().opacity(0.0001) // Hack to ensure tap gesture works everywhere on the screen (bug?)
                VStack {
                    Images.ghLogo.resizable().scaledToFit().frame(width: 200, height: 200).padding(.top, DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80)
                    SearchTextFieldView(username: $username)
                    Spacer()
                    NavigationLink(destination: FollowerListView(username: self.username, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage, callToActionButton: self.$callToActionButton, showingCustomAlert: self.$showingCustomAlert)) {
                            ButtonView(color: .green, text: "Get Followers").padding(.horizontal, 50).padding(.bottom, 50)
                    }.disabled(getFollowersButtonDisabled) // So they can't navigate to list view they've not entered a username.
                }
                .navigationBarTitle("Search", displayMode: .large)
                .navigationBarHidden(true)
                    .onAppear { self.username = "" } // So we clear the previous entry on return to the page.
            }
                .onTapGesture { UIApplication.shared.endEditing() } // To dissmiss keyboard but need a ZStack hack for it to work.
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(alertTitle: .constant(""), alertMessage: .constant(""), callToActionButton: .constant(""), showingCustomAlert: .constant(false))
    }
}
