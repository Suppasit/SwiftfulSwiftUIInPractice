//
//  NetflixMoviewDetailsView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 5/9/2567 BE.
//

import SwiftUI

struct NetflixMoviewDetailsView: View {
    
    var product: Product = .mock
    
    @State private var progress: Double = 0.2
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                NetflixDetailsHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirplayPressed: {
                        
                    },
                    onXMarkPressed: {
                        
                    }
                )
                
                ScrollView(.vertical) {
                    VStack(spacing: 15) {
                        NetflixDetailsProductView(
                            title: product.title,
                            isNew: true,
                            yearReleased: "2024",
                            seasonCount: 4,
                            hasClosedCaption: true,
                            isTopTen: 6,
                            descriptionText: product.description,
                            castText: "Cast: Nick, Beer, John",
                            onPlayPressed: {
                                
                            },
                            onDownloadPressed: {
                                
                            }
                        )
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    NetflixMoviewDetailsView()
}
