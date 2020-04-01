//
//  ItemInfoView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 30/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ItemInfoView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.blue)
            .frame(height: 140)
            .padding(.horizontal, 20)
            .padding(.top, 20)
    }
}

struct ItemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ItemInfoView()
    }
}
