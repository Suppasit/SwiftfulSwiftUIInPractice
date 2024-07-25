//
//  SpotifyCategoryCell.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 24/7/2567 BE.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    
    var title: String = "Music"
    var isSelected: Bool = false

    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(isSelected ? Color.spotifyGreen : Color.spotifyDarkGray)
            .foregroundStyle(isSelected ? Color.black : Color.spotifyWhite)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color(Color.black).ignoresSafeArea()
        
        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "Title goes here")
            SpotifyCategoryCell(title: "Title goes here", isSelected: true)
            SpotifyCategoryCell(title: "All", isSelected: true)
        }
    }
}
