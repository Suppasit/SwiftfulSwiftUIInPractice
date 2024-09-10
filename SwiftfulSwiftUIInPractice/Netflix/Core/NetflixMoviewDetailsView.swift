//
//  NetflixMoviewDetailsView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 5/9/2567 BE.
//

import SwiftUI
import SwiftfulRouting

struct NetflixMoviewDetailsView: View {
    
    @Environment(\.router) var router

    var product: Product = .mock
    
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []
    
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
                        router.dismissScreen()
                    }
                )
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 15) {
                        detailsProductSection
                        buttonSection
                        productsGridSection
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private var detailsProductSection: some View {
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
    
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMoviewDetailsView(product: product)
        }
    }

    private var buttonSection: some View {
        HStack(spacing: 2) {
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            
            RateButton { selection in
                // do something wit selection
            }
            
            ShareButton()
        }
        .padding(.leading, 32)
    }
 
    private var productsGridSection: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), alignment: .center, spacing: 8, pinnedViews: []) {
                ForEach(products) { product in
                    NetflixMoviewCell(
                        imageName: product.firstImage,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded,
                        topTenRanking: nil
                    )
                    .onTapGesture {
                        onProductPressed(product: product)
                    }
                }
            }
        }
        .foregroundStyle(.netflixWhite)
        
    }
}

#Preview {
    RouterView { _ in
        NetflixMoviewDetailsView()
    }
}
