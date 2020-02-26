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
    @State private var error = ""
    
    var body: some View {
        List {
            ForEach(followers) { follower in
                Text(follower.login)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarHidden(hideNavBar)
        .navigationBarTitle("\(username)", displayMode: .large)
        .onAppear(perform: fetchFollowers)
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Bad Stuff Happened"), message: Text(error), dismissButton: .cancel(Text("Ok")))
        }
    }
    
    
    func fetchFollowers() {
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print("Followers.Count = \(followers.count)")
                print(followers)
                self.followers = followers
                
            case .failure(let error):
                self.error = error.rawValue
                self.showErrorAlert = true
            }                
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



