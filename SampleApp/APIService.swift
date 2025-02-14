//
//  APIService.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 12/02/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetchPosts() async throws -> [Post]
}

class APIService: APIServiceProtocol {
    func fetchPosts() async throws -> [Post] {
        let url = URL(string: "https://dummyjson.com/posts")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(PostsResponse.self, from: data)
        return decodedData.posts
    }
}

struct PostsResponse: Codable {
    let posts: [Post]
}

