//
//  PostsViewModel.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 12/02/25.
//

import Foundation
import Combine

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchPosts() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let posts = try await apiService.fetchPosts()
                DispatchQueue.main.async {
                    self.posts = posts
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
