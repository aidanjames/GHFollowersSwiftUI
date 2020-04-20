//
//  UserInfoView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 27/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SafariServices
import SwiftUI

struct UserInfoView: View {
    
    var username: String
    @State private var user: User?
    @State private var showingError = false
    @State private var errorTitle = "Something went wrong"
    @State private var error: String?
    @State private var errorButtonText = "Ok"
    
    // Variables for when the user selects the 'GitHub profile' button
    @State private var showingSafari = false
    @State private var url: URL?
    
    // Variables for when the user selects 'Get followers' button
    @Binding var newUsername: String?
    @Binding var searchText: String
    @Binding var followers: [Follower]
    @Binding var loadingData: Bool
    @Binding var moreFollowersAvailable: Bool
    @Binding var showingEmptyStateView: Bool
    @Binding var showingModalError: Bool
    @Binding var searchError: String
    @Binding var hideNavBar: Bool
    @Binding var showingCancelButton: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if user != nil {
                        HeaderInfoView(user: user!)
                        ItemInfoView(user: user!, itemInfoType: .repos) {
                            guard self.url != nil else { return }
                            self.showingSafari.toggle()
                        }
                        .sheet(isPresented: $showingSafari) {
                            SafariView(url: self.url!).edgesIgnoringSafeArea(.all)
                        }
                        ItemInfoView(user: user!, itemInfoType: .followers) {
                            guard self.user?.followers != 0 else {
                                self.errorTitle = "No followers"
                                self.error = "This user has no followers. What a shame ☹️."
                                self.showingError.toggle()
                                return
                            }
                            self.presentationMode.wrappedValue.dismiss()
                            self.newUsername = self.username
                            self.fetchFollowers()
                        }
                        Text("GitHub since \(user?.createdAt.convertToMonthYearFormat() ?? "Unknown")").padding(.top).foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .onAppear(perform: fetchUserInfo)
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Text("Done").foregroundColor(.green)
                    }
                )
            }
            if showingError {
                CustomAlertView(titleLabel: errorTitle, bodyLabel: error ?? "Unknown error", callToActionButton: errorButtonText, showingModal: $showingError)
            }
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
        self.loadingData = true
        NetworkManager.shared.getFollowers(for: self.newUsername!, page: 1) { result in
            DispatchQueue.main.async { self.loadingData = false }
            switch result {
            case .success(let followers):
                DispatchQueue.main.async {
                    UIApplication.shared.endEditing()
                    self.showingCancelButton = false
                    self.hideNavBar = false
                    self.searchText = ""
                    self.moreFollowersAvailable = true
                }
                
                if followers.count < 100 { self.moreFollowersAvailable = false }
                self.followers = followers
                if self.followers.isEmpty { self.showingEmptyStateView = true }
                
            case .failure(let error):
                self.searchError = error.rawValue
                self.showingModalError = true
            }
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let username = "aidanjames"
        return UserInfoView(username: username, newUsername: .constant(nil), searchText: .constant(""), followers: .constant([]), loadingData: .constant(false), moreFollowersAvailable: .constant(false), showingEmptyStateView: .constant(false), showingModalError: .constant(false), searchError: .constant(""), hideNavBar: .constant(false), showingCancelButton: .constant(false))
    }
}
