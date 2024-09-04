//
//  NetflixMoviewCell.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 3/9/2567 BE.
//

import SwiftUI

struct NetflixMoviewCell: View {
    
    var width: CGFloat = 90
    var height: CGFloat = 140
    var imageName: String = Constants.randomImage
    var title: String? = "Moview Title"
    var isRecentlyAdded: Bool = false
    var topTenRanking: Int? = nil
    
    var body: some View {
        HStack(alignment: .bottom, spacing: -8) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(y: 20)
            }
            
            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)
                
                VStack(spacing: 0) {
                    if let title, let firstWord = title.components(separatedBy: " ").first {
                        Text(firstWord)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                        
                        Text("Recently Added")
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity)
                            .background(.netflixRed)
                            .cornerRadius(2)
                            .offset(y: 2)
                            .lineLimit(1)
                            .font(.caption)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.1)
                            .padding(.horizontal, 8)
                            .opacity(isRecentlyAdded ? 1 : 0)
                    }
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .cornerRadius(4)
            .frame(width: width, height: height)
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ScrollView {
            NetflixMoviewCell(isRecentlyAdded: true)
            NetflixMoviewCell(isRecentlyAdded: false)
            NetflixMoviewCell(isRecentlyAdded: true, topTenRanking: 2)
            NetflixMoviewCell(isRecentlyAdded: false, topTenRanking: 2)
            NetflixMoviewCell(isRecentlyAdded: true, topTenRanking: 10)
            NetflixMoviewCell(isRecentlyAdded: false, topTenRanking: 10)
        }
    }
}
