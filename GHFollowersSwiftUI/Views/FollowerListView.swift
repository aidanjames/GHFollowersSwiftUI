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
    @State private var showErrorAlert = false
    
    var body: some View {
        VStack {
            List {
                ForEach(followers) { follower in
                    Text(follower.login)
                }
            }
        }
        .navigationBarHidden(hideNavBar)
        .navigationBarTitle("\(username)", displayMode: .large)
        .onAppear(perform: fetchFollowers)
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("No such user"), dismissButton: .cancel(Text("Ok")))
        }
    }
    
    func fetchFollowers() {
    
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, error) in
            guard let followers = followers else {
                self.showErrorAlert = true
                return
            }
            print("Followers.Count = \(followers.count)")
            print(followers)
            self.followers = followers
    
        }
        
        // This is a hugely annoying hack because there's a bug that automatically hides the nav bar even though I say navigationBarHidden(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hideNavBar  = false
        }
        
        
    }
}

struct FollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        return FollowerListView(username: "SAllen0400")
    }
}



