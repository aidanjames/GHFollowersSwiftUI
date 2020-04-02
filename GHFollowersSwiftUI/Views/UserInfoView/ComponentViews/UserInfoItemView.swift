//
//  UserInfoItemView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 30/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct UserInfoItemView: View {
    
    var user: User
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.pink)
                
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack {
                HStack {
                    CountView(image: Image(systemName: "folder"), countType: "Public Repos", count: user.publicRepos)
                    Spacer()
                    CountView(image: Image(systemName: "text.alignleft"), countType: "Public Gists", count: user.publicGists)
                }
                .padding(.horizontal)
                .padding(.top)
                Spacer()
                HStack {
                    Spacer()
                    Text("GitHub Profile")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 50)
                .background(Color.purple)
                .cornerRadius(10)
                .padding(20)
            }
            
        }
        .frame(height: 140)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct UserInfoItemView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(login: "aidanjames", avatarUrl: "", name: "Aidan Pendlebury", location: "London", bio: "I'm just a guy, standing in front of nothing.", publicRepos: 8, publicGists: 7, htmlUrl: "", following: 2, followers: 54, createdAt: "")
        return UserInfoItemView(user: user)
    }
}
