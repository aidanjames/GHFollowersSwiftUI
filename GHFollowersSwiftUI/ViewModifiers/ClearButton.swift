//
//  ClearButton.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 19/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: { self.text = "" }) {
                    SFSymbols.deleteCircle
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                        .padding(8)
                }
            }
        }
    }
}


