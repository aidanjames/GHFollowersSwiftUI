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
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().opacity(0.0001) // Hack to ensure tap gesture works everywhere on the screen (bug?)
                VStack {
                    Image("gh-logo").resizable().scaledToFit().frame(width: 200, height: 200).padding(.top, 80)
                    SearchTextFieldView(username: $username)
                    Spacer()
                    NavigationLink(destination: FollowerListView(username: username), tag: 1, selection: $action) { EmptyView() }
                    Button(action: {
                        guard !self.username.isEmpty else { return }
                        self.action = 1
                    }) {
                        ButtonView(color: .green, text: "Get Followers").padding(.horizontal, 50).padding(.bottom, 50)
                    }
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
        SearchView()
    }
}
