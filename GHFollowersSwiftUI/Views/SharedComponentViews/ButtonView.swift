//
//  ButtonView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 08/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
        
    var color: Color
    var text: String
    
    var buttonAction: () -> Void
    
    var body: some View {
       
        Button(action: buttonAction) {
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
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(color: .green, text: "This") { print("Hi there") }
    }
}
