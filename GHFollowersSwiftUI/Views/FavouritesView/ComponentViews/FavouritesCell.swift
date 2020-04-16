//
//  FavouritesCell.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 16/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct FavouritesCell: View {
    
    let follower: Follower
    
    var body: some View {
        HStack(spacing: 0) {
            AvatarImageView(avatarURL: follower.avatarUrl)
                .frame(width: 60, height: 60)
            Text(follower.login)
                .bold()
                .font(.title)
            .lineLimit(1)
                .padding(.leading, 24)
        }
    }
}

struct FavouritesCell_Previews: PreviewProvider {
    static var previews: some View {
        let follower = Follower(login: "Sallen0400", avatarUrl: "https://avatars2.githubusercontent.com/u/10645516?v=4")
        return FavouritesCell(follower: follower)
    }
}
