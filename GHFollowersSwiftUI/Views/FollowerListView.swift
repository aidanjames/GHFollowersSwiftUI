//
//  FollowerListView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 24/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct FollowerListView: View {
    
    var username: String
    @State private var hideNavBar = true
    @State private var followers = [Follower]()
    @State private var error = ""
    @State private var showingModalError = false
    
    var followersChunked: [[Follower]] {
        followers.chunked(into: 3)
    }
    
    var body: some View {
        ZStack {
            if showingModalError {
                ZStack {
                    Color.black
                        .opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    CustomAlertView(titleLabel: "Bad Stuff Happened", bodyLabel: error, callToActionButton: "Ok", showingModal: $showingModalError)
                }
            } else {
                ScrollView {
                    if followersChunked.isEmpty { // Without this I was finding the view would sometimes load as empty for some reason. It seems like a bug.
                        HStack {
                            Spacer()
                        }
                    } else {
                        ForEach(followersChunked, id: \.self) { row in
                            HStack {
                                ForEach(row) { follower in
                                    FollowerCellView(image: Image("avatar-placeholder"), username: follower.login)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarHidden(hideNavBar)
        .navigationBarTitle("\(username)", displayMode: .large)
        .onAppear(perform: fetchFollowers)
    }
    
    
    func fetchFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print("Followers.Count = \(followers.count)")
                //                print(followers)
                self.followers = followers
                print("Followers chuncked count: \(self.followersChunked.count)")
            case .failure(let error):
                self.error = error.rawValue
                self.showingModalError = true
            }                
        }
        
        // This is a hugely annoying hack because there's a bug that automatically hides the nav bar even though I say navigationBarHidden(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideNavBar  = false
        }
        
        
    }
}

struct FollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        return FollowerListView(username: "SAllen0400")
    }
}



