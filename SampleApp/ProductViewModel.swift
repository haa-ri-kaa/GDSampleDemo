//
//  PostsViewModel.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 12/02/25.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let debounceTime = 0.5
    private let productService: ProductService
    
    private var searchSubject = PassthroughSubject<String, Never>()
    
    init(productService: ProductService = ProductService.shared) {
        self.productService = productService
        searchSubject
            .debounce(for: .seconds(debounceTime), scheduler: DispatchQueue.main)
            .sink { [weak self] title in
                self?.loadProductsByTitle(title: title)
            }
            .store(in: &cancellables)
    }
    
    func loadProducts() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let products = try await self.productService.fetchProducts(offset: 0, limit: 10)
                await MainActor.run {
                    self.products = products
                }
            } catch {
                print("Error fetching products: \(error)")
            }
        }
    }
    
    func loadProductsByCategory(categoryID: Int) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let products = try await self.productService.fetchProductsByCategory(categoryID: categoryID)
                await MainActor.run {
                    self.products = products
                }
            } catch {
                print("Error fetching category products: \(error)")
            }
        }
    }
    
    func loadProductsByTitle(title: String) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let products = try await self.productService.fetchProductsByTitle(title: title)
                await MainActor.run {
                    self.products = products
                }
            } catch {
                print("Error fetching products by title: \(error)")
            }
        }
    }
}
