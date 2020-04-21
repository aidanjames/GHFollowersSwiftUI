//
//  CountView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 02/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct CountView: View {
    
    var image: Image
    var countType: String = ""
    var count: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                image
                Text(countType)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.leading, 12)
            }
            Text("\(count)")
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(height: 18)
                .padding(.top, 4)
        }
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CountView(image: SFSymbols.repos, countType: "Public Repos", count: 3)
            CountView(image: SFSymbols.followers, countType: "Followers", count: 6)
            CountView(image: SFSymbols.following, countType: "Following", count: 21)
            CountView(image: SFSymbols.gists, countType: "Public Gists", count: 0)
        }
    }
}
