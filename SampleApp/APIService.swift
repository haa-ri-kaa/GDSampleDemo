//
//  APIService.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 12/02/25.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
    func fetchData<T: Codable>(from url: URL) async throws -> T
}

actor NetworkService: NetworkServiceProtocol {
    func fetchData<T: Codable>(from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

class ProductService {
    static let shared = ProductService(networkService: NetworkService())
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://api.escuelajs.co/api/v1"
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchProducts(offset: Int, limit: Int) async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products?offset=\(offset)&limit=\(limit)")!
        return try await networkService.fetchData(from: url)
    }
    
    func fetchProductsByCategory(categoryID: Int) async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products/?categoryId=\(categoryID)")!
        return try await networkService.fetchData(from: url)
    }
    
    func fetchProductsByTitle(title: String) async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products/?title=\(title)")!
        return try await networkService.fetchData(from: url)
    }
}

