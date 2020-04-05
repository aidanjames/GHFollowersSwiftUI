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
            VStack {
                Image("gh-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 80)
                TextField("Enter a username", text: $username)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary, lineWidth: 2)
                    )
                    .padding()
                    .multilineTextAlignment(TextAlignment.center)
                    .disableAutocorrection(true)
                    .font(.title)
                    .padding(.horizontal, 40)
                    .padding(.top, 40)
                Spacer()
                NavigationLink(destination: FollowerListView(username: username), tag: 1, selection: $action) {
                    EmptyView()
                }
                Button(action: {
                    guard !self.username.isEmpty else { return }
                    self.action = 1
                }) {
                    HStack {
                        Spacer()
                        Text("Get Followers")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
            .navigationBarTitle("Search", displayMode: .large)
            .navigationBarHidden(true)
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
