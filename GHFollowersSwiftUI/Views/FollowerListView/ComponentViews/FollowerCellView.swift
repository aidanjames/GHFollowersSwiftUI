//
//  FollowerListItemView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 26/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct FollowerCellView: View {
    
    var username: String = ""
    var imageURL: String = ""
    
    var body: some View {
        VStack {
            AvatarImageView(avatarURL: imageURL)
            Text(username).fontWeight(.bold).lineLimit(1)
        }
        .padding(.vertical, 8)
    }
    
}

struct FollowerListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerCellView(username: "aidanjames", imageURL: "https://avatars3.githubusercontent.com/u/44542889?v=4")
            .previewLayout(.sizeThatFits)
    }
}
