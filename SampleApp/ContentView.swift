//
//  ContentView.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 12/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ProductViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(Localizations.searchProducts, text: $searchText, onCommit: {
                    viewModel.loadProductsByTitle(title: searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                List {
                    ForEach(viewModel.products) { product in
                        productRow(product)
                            .onAppear {
                                if product == viewModel.products.last {
                                    viewModel.loadProducts()
                                }
                            }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .navigationTitle(Localizations.products)
                .onAppear {
                    viewModel.loadProducts()
                }
            }
        }
    }
    
    // MARK: - Product Row
    private func productRow(_ product: Product) -> some View {
        HStack {
            productImage(product)
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text(String(format: Localizations.price, String(format: "%.2f", product.price)))
                    .foregroundColor(.gray)
            }
        }
    }
    
    // MARK: - Product Image
    private func productImage(_ product: Product) -> some View {
        Group {
            if let imageUrl = product.images.first, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}
