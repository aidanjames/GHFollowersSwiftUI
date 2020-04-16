//
//  AvatarImageView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 16/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct AvatarImageView: View {
    
    let cache = NetworkManager.shared.cache
    var avatarURL: String
    @State private var image = Image("avatar-placeholder")
    
    var body: some View {
        image
        .resizable()
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear(perform: downloadImage)
    }
    
    func downloadImage() {
        
        let cacheKey = NSString(string: avatarURL)
        if let image = cache.object(forKey: cacheKey) {
            self.image = Image(uiImage: image)
            return
        }
        
        guard let url = URL(string: avatarURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = Image(uiImage: image)
            }
        }
        task.resume()
    }
}

struct AvatarImageView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarImageView(avatarURL: "https://avatars2.githubusercontent.com/u/10645516?v=4")
    }
}
