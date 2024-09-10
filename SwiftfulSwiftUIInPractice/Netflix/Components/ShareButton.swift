//
//  ShareButton.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 10/9/2567 BE.
//

import SwiftUI

struct ShareButton: View {
    
    var url: String = "https://www.swiftful-thinking.com"
    
    @ViewBuilder
    var body: some View {
        if let url = URL(string: url) {
            ShareLink(item: url) {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                        .font(.title)
                    
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(Color.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ShareButton()
    }
}
