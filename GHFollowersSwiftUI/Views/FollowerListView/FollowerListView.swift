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
    @State private var moreFollowersAvailable = true
    @State private var page = 1
    @State private var loadingData = false
    @State private var showingEmptyStateView = false
    
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
        // Because there's no easy way to hide list separators
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        ZStack {
            if showingModalError {
                CustomAlertView(titleLabel: "Bad Stuff Happened", bodyLabel: self.error, callToActionButton: "Ok", showingModal: self.$showingModalError)
            } else {
                List {
                    if !hideNavBar && !followersChunked.isEmpty { // Hack so that it doesn't appear before the nav bar
                        FilterView(searchText: $searchText)
                    }
                    if followersChunked.count > 0 {
                        ForEach(followersChunked, id: \.self) { row in
                            HStack(spacing: 20) {
                                ForEach(row, id: \.self) { follower in
                                    FollowerCellView(username: follower.login, imageURL: follower.avatarUrl)
                                }
                                // Below is a hack to prevent a row with only one or two followers taking up all the space. This basically just presents blank FollowerCellViews. Yuck.
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
                        if moreFollowersAvailable { // Hack so we know we've scrolled to the bottom of the page so we can fetch the next page.
                            Circle().opacity(0).onAppear() {
                                self.page += 1
                                self.fetchFollowers()
                            }
                        }
                    }
                }
                if loadingData {
                    ActivityIndicatorView()
                } else if showingEmptyStateView && !hideNavBar {
                    EmptyStateView()
                }
            }
        }
        .navigationBarHidden(self.hideNavBar)
        .navigationBarTitle("\(self.username)", displayMode: .large)
        .onAppear(perform: self.fetchFollowers)
    }
    
    
    func fetchFollowers() {
        self.loadingData = true
        NetworkManager.shared.getFollowers(for: username, page: page) { result in
            DispatchQueue.main.async { self.loadingData = false }
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.moreFollowersAvailable = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty { self.showingEmptyStateView = true }
            case .failure(let error):
                self.error = error.rawValue
                self.showingModalError = true
            }                
        }
        
        // This is an annoying hack because there's a bug that automatically hides the nav bar even though I say navigationBarHidden(false)
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





