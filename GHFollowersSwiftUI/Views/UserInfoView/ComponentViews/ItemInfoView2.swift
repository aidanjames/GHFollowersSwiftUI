//
//  ItemInfoView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 30/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ItemInfoView2: View {
    var user: User
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .frame(height: 140)
            
            VStack {
                HStack {
                    CountView(image: Image(systemName: "person.2"), countType: "Followers", count: user.followers)
                    Spacer()
                    CountView(image: Image(systemName: "heart"), countType: "Following", count: user.following)
                }
                .padding(.horizontal, 20)
                .padding(.top)
                Spacer()
                HStack {
                    Spacer()
                    Text("Get Followers")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 50)
                .background(Color.green)
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
        return ItemInfoView2(user: user)
    }
}