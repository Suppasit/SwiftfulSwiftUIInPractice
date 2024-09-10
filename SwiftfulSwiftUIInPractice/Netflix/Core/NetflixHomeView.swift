//
//  NetflixHomeView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 28/8/2567 BE.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct NetflixHomeView: View {
    
    @Environment(\.router) var router
    
    @State private var filters = FilterModel.mockAray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var scrollViewOffset: CGFloat = .zero
    
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
 
            backgrundGradientLayer
            
            scrollViewLayer
            
            fullHaderWithFilter
            
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard productRows.isEmpty else { return }
        
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
            heroProduct = products.first
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.compactMap { $0.brand })
            for brand in allBrands {
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private var backgrundGradientLayer: some View {
        ZStack {
            LinearGradient(colors: [.netflixDarkGray.opacity(1), .netflixDarkGray.opacity(0)], startPoint: .top, endPoint: .bottom )
                .ignoresSafeArea()
            LinearGradient(colors: [.netflixDarkRed.opacity(0.5), .netflixDarkRed.opacity(0)], startPoint: .top, endPoint: .bottom )
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, 400 + (scrollViewOffset * 0.75)))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    private var fullHaderWithFilter: some View {
        VStack(spacing: 0) {
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -20 {
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter) { newFilter  in
                        selectedFilter = newFilter
                    } onXMarkPressed: {
                        selectedFilter = nil
                    }
                    .padding(.top, 16)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                    
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
        }
    }
    
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMoviewDetailsView(product: product)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
    }
    
    private func heroCell(product: Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: [
                product.category.capitalized,
                product.brand ?? "XXX"
            ],
            onBackgroundPressed: {
                onProductPressed(product: product)
            },
            onPlayPressed: {
                onProductPressed(product: product)
            },
            onMyListPressed: {
                
            }
        )
        .padding(24)
        
    }
    
    private var scrollViewLayer: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false,
            content: {
                VStack(spacing: 4) {
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        heroCell(product: heroProduct)
                    }
                    
                    categoryRows
                    
                }
            },
            onScrollChanged: { offset in
                scrollViewOffset = min(0, offset.y)
            }
        )
    }
    
    private var categoryRows: some View {
        LazyVStack(spacing: 16) {
            ForEach(Array(productRows.enumerated()), id: \.offset) { rowIndex, row in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title)
                        .font(.headline)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id: \.offset) { index, product in
                                NetflixMoviewCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded:  product.recentlyAdded,
                                    topTenRanking: rowIndex == 1 ? index : nil
                                )
                                .onTapGesture {
                                    onProductPressed(product: product)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
}

#Preview {
    RouterView { _ in
        NetflixHomeView()
    }
}
