//
//  GFButtonView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 10/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    
    var color: Color
    var text: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .frame(height: 50)
        .background(color)
        .cornerRadius(10)
    }
}

struct GFButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(color: .green, text: "Test button")
            .previewLayout(.sizeThatFits)
    }
}
