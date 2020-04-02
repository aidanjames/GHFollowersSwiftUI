//
//  HeaderInfoView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 30/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct HeaderInfoView: View {
    
    @State private var image: Image = Image("avatar-placeholder")
    let cache = NetworkManager.shared.cache
    
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                image
                    .resizable()
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.leading, 20)
                    .padding(.top, 20)
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.login).font(.largeTitle).fontWeight(.bold).padding(.top).lineLimit(1)
                    Text(user.name ?? "").foregroundColor(.gray)
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(user.location ?? "No Location")
                    }.foregroundColor(.gray)
                }.padding(.leading, 12)
                Spacer()
            }
            Text(user.bio ?? "No Bio").foregroundColor(.gray)
                .lineLimit(2)
                .padding(.horizontal, 20)
                .padding(.top)
        }.onAppear {
            self.downloadImage(from: self.user.avatarUrl)
        }
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

struct HeaderInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(login: "aidanjames", avatarUrl: "https://avatars3.githubusercontent.com/u/44542889?v=4", name: "Aidan Pendlebury", location: "London", bio: "A good man with a nice hat", publicRepos: 1, publicGists: 0, htmlUrl: "https://github.com/aidanjames", following: 2, followers: 0, createdAt: "2018-10-28T08:50:08Z")
        
        return HeaderInfoView(user: user)
    }
}
