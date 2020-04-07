//
//  ItemInfoView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 07/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

enum ItemInfoType {
    case repos, followers
}

struct ItemInfoView: View {
    
    var user: User
    var itemInfoType: ItemInfoType
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .frame(height: 140)
            
            VStack {
                HStack {
                    CountView(image: Image(systemName: itemInfoType == .repos ? "folder" : "person.2"), countType: itemInfoType == .repos ? "Public Repos" : "Followers", count: itemInfoType == .repos ? user.publicRepos : user.followers)
                    Spacer()
                    CountView(image: Image(systemName: itemInfoType == .repos ? "text.alignleft" : "heart"), countType: itemInfoType == .repos ? "Public Gists" : "Following", count: itemInfoType == .repos ? user.publicGists : user.following)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                Spacer()
                HStack {
                    Spacer()
                    Text(itemInfoType == .repos ? "GitHub Profile" : "Get Followers")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 50)
                .background(itemInfoType == .repos ? Color.purple : Color.green)
                .cornerRadius(10)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
            }
        }
        .frame(height: 140)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct ItemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(login: "aidanjames", avatarUrl: "", name: "Aidan Pendlebury", location: "London", bio: "I'm just a guy, standing in front of nothing.", publicRepos: 8, publicGists: 7, htmlUrl: "", following: 2, followers: 54, createdAt: "")
        return VStack {
            ItemInfoView(user: user, itemInfoType: .repos)
            ItemInfoView(user: user, itemInfoType: .followers)
        }
    }
}
