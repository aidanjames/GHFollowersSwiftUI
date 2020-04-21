//
//  AvatarImageView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 16/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct AvatarImageView: View {
    
    var avatarURL: String
    @State private var image = Images.avatarPlaceholder
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onAppear(perform: downloadImage)
    }
    
    func downloadImage() {
        NetworkManager.shared.downloadImage(from: avatarURL) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: image)
            }
        }
    }
    
}

struct AvatarImageView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarImageView(avatarURL: "https://avatars2.githubusercontent.com/u/10645516?v=4")
            .previewLayout(.sizeThatFits)
    }
}
