//
//  ActivityIndicatorView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 21/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView: View {
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground).opacity(0.8).edgesIgnoringSafeArea(.all)
            ActivityIndicator(style: .large)
        }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
