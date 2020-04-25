//
//  ExperimentalFollowerListView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 25/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ExperimentalFollowerListView: View {
    
    var username: String
    @State private var user: User?
    @State private var showingError = false
    @State private var errorTitle = "Something went wrong"
    @State private var error: String?
    @State private var errorButtonText = "Ok"
    @State private var showingSafari = false
    @State private var url: URL?
    
    @State private var hideNavBar = true
    @State private var followers = [Follower]()
    
    // Alert bindings - I have to bind these to the TabView (ContentView) so an alert covers the whole screen including the tab bar.
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var callToActionButton: String
    @Binding var showingCustomAlert: Bool
    
    @State private var searchText = ""
    @State private var moreFollowersAvailable = true
    @State private var page = 1
    @State private var loadingData = false
    @State private var showingEmptyStateView = false
    @State private var showingUserInfoView = false
    @State private var selectedUser = ""
    @State private var reloadPageWithNewUser = false
    @State private var newUserName: String?
    @State private var showingCancelButton: Bool = false
    @State private var showingSearchField = false
    
    // To break the users down into subsets of 3 to help emulate a collection view
    var followersChunked: [[Follower]] {
        if searchText.isEmpty {
            return followers.chunked(into: 3)
        } else {
            let filteredFollowers = followers.filter { $0.login.lowercased().contains(self.searchText.lowercased()) }
            return filteredFollowers.chunked(into: 3)
        }
    }
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if self.user != nil {
                        HeaderInfoView(user: self.user!).padding(0)
                        ItemInfoView(user: user!, itemInfoType: .repos) {
                            guard self.url != nil else { return }
                            self.showingSafari.toggle()
                        }.padding(.top, 0)
                            .padding(.bottom, 10)
                            .sheet(isPresented: $showingSafari) {
                                SafariView(url: self.url!).edgesIgnoringSafeArea(.all)
                        }
                    if showingEmptyStateView {
                        Text("This loser has no followers ☹️").padding()
                    } else {
                       HStack {
                            Text("Followers").font(.headline)
                            Button(action: { self.showingSearchField.toggle() }) {
                                Image(systemName: "line.horizontal.3.decrease.circle.fill").font(.title).foregroundColor(.green).padding()
                            }
                        }
                    }
                }
                List {
                    if followersChunked.count > 0 || !searchText.isEmpty {
                        if showingSearchField {
                            FilterView(searchText: $searchText, navigationTitleHidden: $hideNavBar, showingCancelButton: $showingCancelButton)
                        }
                        ForEach(followersChunked, id: \.self) { row in
                            HStack(spacing: 20) {
                                ForEach(row, id: \.self) { follower in
                                    Button(action: {
                                        self.selectedUser = follower.login
                                        self.showingUserInfoView.toggle()
                                    }) {
                                        FollowerCellView(username: follower.login, imageURL: follower.avatarUrl)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .sheet(isPresented: self.$showingUserInfoView) { UserInfoView(username: self.selectedUser, newUsername: self.$newUserName, searchText: self.$searchText, followers: self.$followers, loadingData: self.$loadingData, moreFollowersAvailable: self.$moreFollowersAvailable, showingEmptyStateView: self.$showingEmptyStateView, showingModalError: self.$showingCustomAlert, searchError: self.$alertMessage, hideNavBar: self.$hideNavBar, showingCancelButton: self.$showingCancelButton) }
                                }
                                // Below is a hack to prevent a row with less than 3 followers taking up unequal space. Yuck.
                                if row.count < 3 {
                                    ForEach(1...(3 - row.count), id: \.self) { _ in Circle().opacity(0) }
                                }
                            }.padding(.horizontal, 12)
                        }
                        if moreFollowersAvailable && searchText.isEmpty { // Hack so we know we've scrolled to the bottom of the page so we can fetch the next page.
                            Circle().opacity(0).onAppear() {
                                self.page += 1
                                self.fetchFollowers()
                            }
                        }
                    }
                }
            }
            if loadingData {
                ActivityIndicatorView()
            }
        }
        .navigationBarHidden(self.hideNavBar)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: self.addFavourite) {
                SFSymbols.plus.font(Font.system(size: 22))
                    .padding()
            }
        )
            .onAppear {
                self.fetchUserInfo()
                self.fetchFollowers()
        }
    }
    
    func fetchUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
            case .success(let user):
                self.user = user
                // set url
                guard let url = URL(string: user.htmlUrl) else {
                    self.error = "The url attached to this user is invalid."
                    self.showingError.toggle()
                    return
                }
                self.url = url
            case .failure(let error):
                self.error = error.rawValue
                self.showingError = true
            }
        }
    }
    
    func fetchFollowers() {
        UITableView.appearance().separatorStyle = .none // This removes the divider lines in the list
        let userName = self.newUserName == nil ? self.username : self.newUserName!
        self.loadingData = true
        NetworkManager.shared.getFollowers(for: userName, page: page) { result in
            DispatchQueue.main.async { self.loadingData = false }
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.moreFollowersAvailable = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty { self.showingEmptyStateView = true }
            case .failure(let error):
                self.alertTitle = "Bad stuff happened"
                self.alertMessage = error.rawValue
                self.callToActionButton = "Ok"
                self.showingCustomAlert = true
            }
        }
        
        // This is an annoying hack because there's a bug that automatically hides the nav bar even though I say navigationBarHidden(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideNavBar  = false
        }
    }
    
    func addFavourite() {
        let user = newUserName == nil ? username : newUserName!
        
        NetworkManager.shared.getUserInfo(for: user) { result in
            switch result {
            case .success(let user):
                let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favourite: favourite, actionType: .add) { error in
                    guard let error = error else {
                        self.alertTitle = "Success!"
                        self.alertMessage = "You have successfully favourited this user 🎉"
                        self.callToActionButton = "Hooray!"
                        self.showingCustomAlert.toggle()
                        return
                    }
                    self.alertTitle = "Bad stuff happened"
                    self.alertMessage = error.rawValue
                    self.callToActionButton = "Ok"
                    self.showingCustomAlert.toggle()
                }
            case .failure(let error):
                self.alertTitle = "Bad stuff happened"
                self.alertMessage = error.rawValue
                self.callToActionButton = "Ok"
                self.showingCustomAlert.toggle()
            }
        }
    }
    
}

struct ExperimentalFollowerListView_Previews: PreviewProvider {
    static var previews: some View {
        return ExperimentalFollowerListView(username: "SAllen0400", alertTitle: .constant(""), alertMessage: .constant(""), callToActionButton: .constant(""), showingCustomAlert: .constant(false))
    }
}






