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
    @Binding var navigationTitleHidden: Bool
    @Binding var showingCancelButton: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.headline)
                TextField("Search for a username", text: self.$searchText)
            }
            .padding(5)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.leading)
            .padding(.trailing, !showingCancelButton ? 10 : 0)
            .padding(.bottom)
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        withAnimation {
                            self.navigationTitleHidden = true
                            self.showingCancelButton = true
                        }
                }
            )
            if showingCancelButton {
                Button(action: {
                    withAnimation {
                        UIApplication.shared.endEditing()
                        self.searchText = ""
                        self.navigationTitleHidden = false
                        self.showingCancelButton = false
                    }
                }) {
                    Text("Cancel").foregroundColor(.green)
                }
                .padding(.trailing)
                .padding(.bottom)
            }
        }
        
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(searchText: .constant(""), navigationTitleHidden: .constant(true), showingCancelButton: .constant(false))
    }
}
