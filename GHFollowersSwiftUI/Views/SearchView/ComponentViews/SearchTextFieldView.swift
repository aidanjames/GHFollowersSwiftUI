//
//  SearchTextFieldView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 08/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct SearchTextFieldView: View {
    
    @Binding var username: String
    
    var body: some View {
        TextField("Enter a username", text: $username)
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary, lineWidth: 2)
        )
        .padding()
        .multilineTextAlignment(TextAlignment.center)
        .disableAutocorrection(true)
        .font(.title)
        .padding(.horizontal, 40)
        .padding(.top, 40)    }
}

struct SearchTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextFieldView(username: .constant(""))
    }
}
