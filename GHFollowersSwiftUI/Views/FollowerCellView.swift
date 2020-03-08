//
//  FollowerListItemView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 26/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct FollowerCellView: View {
    
    var image: Image
    var username: String
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(username)
            .lineLimit(1)
        }
        .padding(5)
    }
}

struct FollowerListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerCellView(image: Image("avatar-placeholder"), username: "aidanjames")
            .previewLayout(.sizeThatFits)
    }
}
