//
//  FilterView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 20/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .font(.headline)
            TextField("Search", text: self.$searchText)
        }
        .padding(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1))
        .padding()
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(searchText: .constant(""))
    }
}
