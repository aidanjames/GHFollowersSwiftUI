//
//  SafariView.swift
//  GHFollowersSwiftUI
//
//  Created by Aidan Pendlebury on 10/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        uiViewController.preferredControlTintColor = .systemGreen
    }
    
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url:URL(string: "https://duckduckgo.com")!)
    }
}
