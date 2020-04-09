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
        TextField("Enter a username", text: $username).font(Font.system(size: 22))
            .frame(height: 50)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.systemGray4), lineWidth: 2))
        .multilineTextAlignment(TextAlignment.center)
        .disableAutocorrection(true)
        .padding(.horizontal, 50)
        .padding(.top, 48)
    }
}

struct SearchTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextFieldView(username: .constant(""))
    }
}
