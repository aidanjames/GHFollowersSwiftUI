//
//  UserInfoView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 27/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct UserInfoView: View {
    
    var username: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Text(username)
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Text("Done").foregroundColor(.green)
                    }
            )
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let username = "aidanjp"
        return UserInfoView(username: username)
    }
}
