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
                    .padding(.leading, 12)
            }
            Text("\(count)")
                .frame(height: 18)
                .padding(.top, 4)
        }
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CountView(image: Image(systemName: "folder"), countType: "Public Repos", count: 3)
            CountView(image: Image(systemName: "person.2"), countType: "Followers", count: 6)
            CountView(image: Image(systemName: "heart"), countType: "Following", count: 21)
            CountView(image: Image(systemName: "text.alignleft"), countType: "Public Gists", count: 0)
        }
    }
}