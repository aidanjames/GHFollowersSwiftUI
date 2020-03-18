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
    @State private var searchText = ""
    @State private var activityIndicatorAnimating = true
    @State private var moreFollowersAvailable = true
    @State private var page = 1
    
    var followersChunked: [[Follower]] {
        if searchText.isEmpty {
            return followers.chunked(into: 3)
        } else {
            let filteredFollowers = followers.filter { $0.login.lowercased().contains(self.searchText.lowercased()) }
            return filteredFollowers.chunked(into: 3)
        }
    }
    
    init(username: String) {
        self.username = username
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
            ZStack {
                if showingModalError {
                    ZStack {
                        Color.black
                            .opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        CustomAlertView(titleLabel: "Bad Stuff Happened", bodyLabel: self.error, callToActionButton: "Ok", showingModal: self.$showingModalError)
                    }
                } else {
                    List {
                        if !hideNavBar { // Hack so that it doesn't appear before the nav bar
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.secondary)
                                    .font(.headline)
                                TextField("Search", text: self.$searchText)
                            }
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1))
                            .padding()
                        }
                        if followersChunked.isEmpty { // Without this I was finding the view would sometimes load as empty for some reason. It seems like a bug.
                            HStack {
                                Spacer()
                            }
                        } else {
                            ForEach(followersChunked, id: \.self) { row in
                                HStack(spacing: 20) {
                                    ForEach(row, id: \.self) { follower in
                                        FollowerCellView(username: follower.login, imageURL: follower.avatarUrl)
                                    }
                                    // Below is a hack to prevent a row with only one or two followers taking up all the space. This basically just presents blank FollowerCellViews
                                    if row.count == 2 && self.followersChunked.count > 0 {
                                        FollowerCellView(username: "", imageURL: "")
                                    }
                                    if row.count == 1 && self.followersChunked.count > 0  {
                                        FollowerCellView(username: "", imageURL: "")
                                        FollowerCellView(username: "", imageURL: "")
                                    }
                                }
                                .padding(.horizontal, 12)
                                
                            }
                            if moreFollowersAvailable { // Paging functionality
                                HStack {
                                    Spacer()
                                    ActivityIndicator(isAnimating: self.$activityIndicatorAnimating, style: .large)
                                        .onAppear() {
                                            self.page += 1
                                            self.fetchFollowers()
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(self.hideNavBar)
            .navigationBarTitle("\(self.username)", displayMode: .large)
            .onAppear(perform: self.fetchFollowers)
    }
    
    
    func fetchFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: page) { result in
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.moreFollowersAvailable = false }
                print("Followers.Count = \(followers.count)")
                self.followers.append(contentsOf: followers)
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



