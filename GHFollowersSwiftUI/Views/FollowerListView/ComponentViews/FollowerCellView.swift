//
//  FollowerListItemView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 26/02/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct FollowerCellView: View {
    
    @State private var image: Image = Image("avatar-placeholder")
    var username: String = ""
    var imageURL: String = ""
    let cache = NetworkManager.shared.cache
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onAppear() {
                    if self.imageURL.isEmpty { self.image = Image("") }
                    self.downloadImage(from: self.imageURL)
            }
            Text(username).fontWeight(.bold).lineLimit(1)
        }
        .padding(.vertical, 8)
    }
    
    
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = Image(uiImage: image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
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

struct FollowerListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerCellView(username: "aidanjames", imageURL: "www.google.com")
            .previewLayout(.sizeThatFits)
    }
}
