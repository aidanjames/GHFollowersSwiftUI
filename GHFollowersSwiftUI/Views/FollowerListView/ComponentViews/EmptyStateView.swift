//
//  EmptyStateView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 20/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("This user doesn't have any followers. Go follow them 😄.")
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 85)
                .frame(width: 310, height: 300)
                .offset(y: 50)
            Image("empty-state-logo")
                .scaleEffect(1.1)
            .offset(x: 100, y: 20)
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()
    }
}
