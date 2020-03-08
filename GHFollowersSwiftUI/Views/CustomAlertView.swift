//
//  CustomAlertView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 03/03/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct CustomAlertView: View {
    
    var titleLabel: String
    var bodyLabel: String
    var callToActionButton: String
    
    @Binding var showingModal: Bool
    
    var body: some View {
        VStack {
            Text(titleLabel)
                .font(.headline)
                .bold()
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .frame(height: 38)
            Text(bodyLabel)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .padding(.bottom, 20)
                .padding(.top, 8)
                .padding(.horizontal, 20)
            Button(action: { self.showingModal = false }) {
                    Text(callToActionButton)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.pink)
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(width: 280, height: 220)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 20)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        let title = "Bad Stuff Happened"
        let body = "Unable to complete your request. Please check your internet connection."
        let buttonText = "Ok"
        return CustomAlertView(titleLabel: title, bodyLabel: body, callToActionButton: buttonText, showingModal: .constant(true))
    }
}
