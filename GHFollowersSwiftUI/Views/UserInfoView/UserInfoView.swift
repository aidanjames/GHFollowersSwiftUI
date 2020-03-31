//
//  UserInfoView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 27/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct UserInfoView: View {
    
    var username: String
    @State private var user: User?
    @State private var showingError = false
    @State private var error: String?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if user != nil {
                        HeaderInfoView(user: user!)
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
                CustomAlertView(titleLabel: "Something went wrong", bodyLabel: error ?? "Unknown error", callToActionButton: "Ok", showingModal: $showingError)
            }
        }
    }
    
    func fetchUserInfo() {
        
        NetworkManager.shared.getUserInfo(for: username) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.error = error.rawValue
                self.showingError = true
            }
        }
        
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let username = "aidanjames"
        return UserInfoView(username: username)
    }
}
