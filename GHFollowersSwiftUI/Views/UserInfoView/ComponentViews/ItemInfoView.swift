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
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 18))
            VStack {
                HStack {
                    CountView(image: itemInfoType == .repos ? SFSymbols.repos : SFSymbols.followers, countType: itemInfoType == .repos ? "Public Repos" : "Followers", count: itemInfoType == .repos ? user.publicRepos : user.followers)
                    Spacer()
                    CountView(image: itemInfoType == .repos ? SFSymbols.gists : SFSymbols.following, countType: itemInfoType == .repos ? "Public Gists" : "Following", count: itemInfoType == .repos ? user.publicGists : user.following)
                }.padding(.horizontal, 20).padding(.top, 20)
                Spacer()
                Button(action: action) {
                    ButtonView(color: itemInfoType == .repos ? .purple : .green, text: itemInfoType == .repos ? "GitHub Profile" : "Get Followers")
                        .padding(.bottom, 20).padding(.horizontal, 20)
                }
            }
        }
        .frame(height: 140)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct ItemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(login: "aidanjames", avatarUrl: "", name: "Aidan Pendlebury", location: "London", bio: "I'm just a guy, standing in front of nothing.", publicRepos: 8, publicGists: 7, htmlUrl: "", following: 2, followers: 54, createdAt: Date())
        return VStack {
            ItemInfoView(user: user, itemInfoType: .repos) { }
            ItemInfoView(user: user, itemInfoType: .followers) { }
        }
        .previewLayout(.sizeThatFits)
    }
}
